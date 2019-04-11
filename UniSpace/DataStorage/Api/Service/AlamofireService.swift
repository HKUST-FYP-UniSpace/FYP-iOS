//
//  AlamofireService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire
import AlamofireImage

typealias DownloadProgress = (_ fractionCompleted: String) -> Void
typealias SendRequestResult = (String?, Error?) -> Void

enum ServerError: LocalizedError {
    case UnknownClassType(object: String)
    case ImageFormatError(format: String)

    var errorDescription: String? {
        get {
            switch self {
            case .UnknownClassType(let object):
                return "Not appropriate \(object)"
            case .ImageFormatError(let format):
                return "Can't convert to \(format) format"
            }
        }
    }
}

class AlamofireService: NSObject {

    public static let shared:AlamofireService = AlamofireService()
    private var manager: SessionManager!
    private let imageCache = AutoPurgingImageCache()

    var headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]

    var uploadHeaders: [String: String] = [
        "Content-Type": "multipart/form-data",
        "Accept": "application/json"
    ]

    public override init() {
        super.init()
        let manager = SessionManager.default
        manager.retrier = ApiRequestRetrier()
        self.manager = manager
    }

    func get(at route: ApiRoute, params: Parameters? = nil) -> DataRequest {
        return request(at: route, method: .get, params: params, encoding: URLEncoding.default)
    }

    func post(at route: ApiRoute, params: Parameters? = nil) -> DataRequest {
        return request(at: route, method: .post, params: params, encoding: JSONEncoding.default)
    }

    func put(at route: ApiRoute, params: Parameters? = nil) -> DataRequest {
        return request(at: route, method: .put, params: params, encoding: JSONEncoding.default)
    }

    func delete(at route: ApiRoute, params: Parameters? = nil) -> DataRequest {
        return request(at: route, method: .delete, params: params, encoding: JSONEncoding.default)
    }

    private func request(at route: ApiRoute, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding) -> DataRequest {
        let response = manager.request(route.url(), method: method, parameters: params, encoding: encoding, headers: headers).validate()
        handleResponse(at: route, response: response, method: method)
        return response
    }

    func easyUpload(at route: ApiRoute, dataFormation: @escaping (_ multipartFormData: MultipartFormData) -> (), completion: @escaping (_ res: DataResponse<Any>) -> Void) {
        upload(at: route, dataFormation: dataFormation) { (dataRequest, error) in
            if let dataRequest = dataRequest {
                dataRequest.responseJSON(completionHandler: { (res) in
                    completion(res)
                })
            }
        }
    }

    private func upload(at route: ApiRoute, dataFormation: @escaping (_ multipartFormData: MultipartFormData) -> (), completion: @escaping (_ dataRequest: DataRequest?, _ error: Error?) -> Void) {
        manager.upload(multipartFormData: dataFormation, to: route.url(), method: .post, headers: uploadHeaders) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                let response = upload.validate()
                self.handleResponse(at: route, response: response, method: nil)
                //                self.logProgress(response)
                completion(response, nil)

            case .failure(let encodingError):
                completion(nil, encodingError)
            }
        }
    }

    func download(at url: String, filename: String, downloadProgress: DownloadProgress?, completion: @escaping (_ url: String?, _ error: Error?) -> Void) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let fileURL = DocumentHandler.shared.createUrlForPDF(filename)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        manager.download(url, to: destination).downloadProgress(closure: { (progress) in
            downloadProgress?(self.roundUpTo2dpWithPrecent(progress.fractionCompleted))
        }).responseData { (response) in
            log.verbose("DOWNLOAD \(response.response?.statusCode ?? 0)", context: "Request: \(url)")
            completion(response.destinationURL?.path, response.result.error)
        }
    }

    func downloadImage(at url: String, downloadProgress: DownloadProgress?, completion: @escaping (_ image: Image?, _ error: Error?) -> Void) {
//        let urlRequest = getURLRequest(url)
//        if let urlRequest = urlRequest, let cachedImage = imageCache.image(for: urlRequest) {
//            print("Obtain from cache: \(url), \(cachedImage.size)")
//            completion(cachedImage, nil)
//            return
//        }

        manager.request(url, method: .get).downloadProgress(closure: { (progress) in
            downloadProgress?(self.roundUpTo2dpWithPrecent(progress.fractionCompleted))
        }).response { (response) in
            log.verbose("DOWNLOAD \(response.response?.statusCode ?? 0)", context: "Request: \(url)")
            let image = response.data == nil ? nil : UIImage(data: response.data!)
            completion(image, response.error)

//            if let image = image, let urlRequest = urlRequest {
//                self.imageCache.add(image, for: urlRequest)
//            }
        }
    }

    private func getURLRequest(_ url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        return URLRequest(url: url)
    }

    private func roundUpTo2dpWithPrecent(_ x: Double) -> String {
        return "\(Double(round(1000 * x) / 10))%"
    }

}

extension AlamofireService {

    private func handleResponse(at route: ApiRoute, response: DataRequest, method: HTTPMethod?) {
        response.responseJSON { (response) in
            let method = method?.rawValue ?? "UPLOAD"
            log.verbose("\(method) \(response.response?.statusCode ?? 0)", context: "Request: \(route.url())")
            self.serverResponse(response)
        }
    }

    private func logProgress(_ response: UploadRequest) {
        if #available(iOS 11.0, *) {
            response.uploadProgress { (progress) in
                if let estimatedTimeRemaining = progress.estimatedTimeRemaining {
                    log.verbose("Upload Progress", context: "\(estimatedTimeRemaining)s left")
                }
            }
        }
    }

    private func serverResponse(_ response:DataResponse<Any>) {
        //        guard response.result.error == nil else {
        //            alamofireErrorResponse(response.result.error!)
        //            return
        //        }

        guard let data = response.data else { return }
        let response = try? JSONDecoder().decode(ServerMessage.self, from: data)
        if let code = response?.code {
            log.warning("Server Response \(code)", context: response?.message)
        }
    }

    private func alamofireErrorResponse(_ alamofireError: Error) {
        if let error = alamofireError as NSError? {
            // error.code 4:
            // Response could not be serialized, input data was nil or zero length.
            // since server might not response anything, this error is ignored
            if error.code != 4 {
                log.error("HTTP Error", context: error.localizedDescription)
            }
        }
    }

    func transform<T>(from: Any?, type: T.Type) -> T? {
        guard let lists = from as? Dictionary<String, Any>, !lists.isEmpty else { return nil }
        for list in lists { return list.value as? T }
        return nil
    }

    func sendLogs(_ url: URL, completion: SendRequestResult?) {
        easyUpload(at: .sendLogs, dataFormation: { (multipartFormData) in
            let filename = url.lastPathComponent
            if let log = try? Data(contentsOf: url) {
                let name = url.deletingPathExtension().lastPathComponent
                multipartFormData.append(log, withName: name, fileName: filename, mimeType: "text/plain")
            } else {
                log.error("File read error", context: filename)
            }
        }) { (res) in
            completion?(nil, res.result.error)
        }
    }

}

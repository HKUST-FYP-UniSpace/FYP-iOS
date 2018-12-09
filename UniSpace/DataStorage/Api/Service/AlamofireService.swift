//
//  AlamofireService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire

class AlamofireService: NSObject {
    
    public static let shared: AlamofireService = AlamofireService()
    private var manager: SessionManager!
    
    static func clearCookies() {
        let storage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
    }
    
    var headers: [String: String] = [
        "Content-Type": "application/json",
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
    
    func request(at route: ApiRoute, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding) -> DataRequest {
        let response = manager.request(route.url(), method: method, parameters: params, encoding: encoding, headers: headers).validate()
        handleResponse(at: route, response: response)
        return response
    }
    
    func easyUpload(at route: ApiRoute, dataFormation: @escaping (_ multipartFormData: MultipartFormData) -> (), completion: @escaping (_ serverMessage: ServerMessage?, _ error: Error?) -> ()) {
        upload(at: route, dataFormation: dataFormation) { (dataRequest, error) in
            guard let dataRequest = dataRequest else {
                completion(nil, error)
                return
            }
            
            dataRequest.responseJSON { (res: DataResponse<Any>) in
                var result: ServerMessage? = nil
                if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
                completion(result, res.result.error)
            }
        }
    }
    
    func upload(at route: ApiRoute, dataFormation: @escaping (_ multipartFormData: MultipartFormData) -> (), completion: @escaping (_ dataRequest: DataRequest?, _ error: Error?) -> ()) {
        manager.upload(multipartFormData: dataFormation, to: route.url()) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                let response = upload.validate()
                self.handleResponse(at: route, response: response)
                self.logProgress(response)
                completion(response, nil)
                
            case .failure(let encodingError):
                completion(nil, encodingError)
            }
        }
    }
    
}

extension AlamofireService {
    
    private func handleResponse(at route: ApiRoute, response: DataRequest) {
        response.responseJSON { (response) in
            log.info("HTTP \(response.response?.statusCode ?? 0)", context: String(format: "Request: %@", route.url()))
            self.serverResponse(response)
        }
    }
    
    private func logProgress(_ response: UploadRequest) {
        response.uploadProgress { (progress) in
            log.info("Upload Progress", context: "\(progress.estimatedTimeRemaining ?? 0)s left")
        }
    }
    
    private func serverResponse(_ response:DataResponse<Any>) {
        guard let data = response.data else { return }
        let response = try? JSONDecoder().decode(ServerMessage.self, from: data)
        if let code = response?.code {
            log.info("Server Response \(code)", context: response?.message)
        }
    }
    
}


// might come in handy later
//extension AlamofireService {
//
//    func uploadImage(at route: ApiRoute, image: UIImage, fileName: String?) -> DataRequest {
//        let imageData = UIImagePNGRepresentation(image)!
//        let headers: [String: String]? = getImageHeader(fileName)
//        return self.upload(at: route, data: imageData, method: .post, headers: headers)
//    }
//
//    func upload(at route: ApiRoute, data: Data, method: HTTPMethod, headers: HTTPHeaders?) -> DataRequest {
//        let response = manager.upload(data, to: route.url(), method: method, headers: headers).validate()
//        handleResponse(at: route, response: response)
//        return response.uploadProgress { (progress) in
//            if #available(iOS 11.0, *) {
//                log.info("Upload Progress", context: "\(progress.estimatedTimeRemaining ?? 0)s left")
//            }
//        }
//    }
//
//    private func getImageHeader(_ name: String?) -> HTTPHeaders? {
//        guard let name = name else { return nil }
//        return [
//            "name": "\(name)"
//        ]
//    }
//
//}

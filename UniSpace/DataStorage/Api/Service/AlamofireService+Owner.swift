//
//  AlamofireService+Owner.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: OwnerService {

    func getOwnerHouseSummary(completion: @escaping ([OwnerHouseSummaryModel]?, Error?) -> Void) {
        get(at: .getOwnerStatsSummary).responseJSON { (res: DataResponse<Any>) in
            var result: [OwnerHouseSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([OwnerHouseSummaryModel].self, from: data) }
            result?.sort(by: { $0.createTime > $1.createTime })
            completion(result, res.result.error)
        }
    }

    func getOwnerTeamsSummary(houseId: Int, completion: @escaping (OwnerTeamsModel?, Error?) -> Void) {
        get(at: .getOwnerTeamSummary(houseId: houseId)).responseJSON { (res: DataResponse<Any>) in
            var result: OwnerTeamsModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(OwnerTeamsModel.self, from: data) }
            result?.teams.sort(by: { $0.id < $1.id })
            result?.reviews.sort(by: { $0.date > $1.date })
            completion(result, res.result.error)
        }
    }

    func replyReivew(reviewId: Int, comment: String, completion: SendRequestResult?) {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        params["comment"] = comment
        post(at: .replyReview(reviewId: reviewId), params: params).responseJSON { (res: DataResponse<Any>) in
            completion?(nil, res.result.error)
        }
    }

    func getHouseData(houseId: Int, filter: ChartFilterOptions, completion: @escaping (ChartDataListModel?, Error?) -> Void) {
        get(at: .getHouseData(houseId: houseId, filter: filter)).responseJSON { (res: DataResponse<Any>) in
            var result: ChartDataListModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ChartDataListModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func createHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?) {
        post(at: .createHouse, params: getHouseParams(model)).responseJSON { (res: DataResponse<Any>) in
            var result: Int? = nil
            if let data = res.result.value { result = self.transform(from: data, type: Int.self) }
            guard let houseId = result else {
                completion?(nil, ServerError.UnknownClassType(object: "House ID"))
                return
            }
            self.createHouseImage(houseId: houseId, images: images, completion: completion)
        }
    }

    func editHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?) {
        put(at: .editHouse(houseId: model.id), params: getHouseParams(model)).responseJSON { (res: DataResponse<Any>) in
            self.createHouseImage(houseId: model.id, images: images, completion: completion)
        }
    }

    private func createHouseImage(houseId: Int, images: [UIImage], completion: SendRequestResult?) {
        easyUpload(
            at: .createHouseImage(houseId: houseId),
            dataFormation: { (multipartFormData) in
                for (index, image) in images.enumerated() {
                    guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                        completion?(nil, ServerError.ImageFormatError(format: "jpeg"))
                        return
                    }
                    multipartFormData.append(imageData, withName: "photo[\(index)]", fileName: "photoURL.jpeg", mimeType: "image/jpeg")
                }
                multipartFormData.append("\(houseId)".data(using: .utf8)!, withName: "houseId")
        }) { (res: DataResponse<Any>) in
            self.sendRequestStandardHandling(res: res, followUpAction: nil, completion: completion)
        }
    }

    func changeHouseStatus(houseId: Int, status: HouseStatus, completion: SendRequestResult?) {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        params["status"] = status.rawValue
        post(at: .changeHouseStatus(houseId: houseId), params: params).responseJSON { (res: DataResponse<Any>) in
            completion?(nil, res.result.error)
        }
    }

}

extension AlamofireService {
    private func getHouseParams(_ model: HouseListModel) -> Parameters {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        params["title"] = model.title
        params["address"] = model.address
        params["subtitle"] = model.subtitle
        params["price"] = model.price
        params["size"] = model.size
        params["rooms"] = model.rooms
        params["beds"] = model.beds
        params["toilets"] = model.toilets

        if model.id != 0 {
            params["houseId"] = model.id
            params["type"] = HouseType.Flat.rawValue
            params["district_id"] = model.district_id
            params["description"] = ""
            params["max_ppl"] = 10
            params["ownerId"] = DataStore.shared.user?.id
        }
        return params
    }
}

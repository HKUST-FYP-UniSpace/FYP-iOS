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
            completion(result, res.result.error)
        }
    }

    func getOwnerTeamsSummary(houseId: Int, completion: @escaping (OwnerTeamsModel?, Error?) -> Void) {
        get(at: .getOwnerTeamSummary(houseId: houseId)).responseJSON { (res: DataResponse<Any>) in
            var result: OwnerTeamsModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(OwnerTeamsModel.self, from: data) }
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
        // TODO
    }

    func createHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?) {
        // TODO
    }

    func editHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?) {
        // TODO
    }

    func changeHouseStatus(houseId: Int, status: HouseStatus, completion: SendRequestResult?) {
        // TODO
    }

}

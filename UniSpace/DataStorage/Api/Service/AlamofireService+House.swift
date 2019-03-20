//
//  AlamofireService+House.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: HouseService {

    func getHouseSuggestions(userId: Int, completion: @escaping ([HouseSuggestionModel]?, Error?) -> Void) {
        get(at: .getHouseSuggestions()).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseSuggestionModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseSuggestionModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getHouseSaved(userId: Int, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        get(at: .getHouseSaved()).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseListModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getHouseHistory(userId: Int, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        // TODO
    }

    func getHouseList(userId: Int, filter: HouseFilterModel, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        get(at: .getHouseList(filter: filter)).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseListModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getHouseView(houseId: Int, completion: @escaping (HouseViewModel?, Error?) -> Void) {
        get(at: .getHouseView(houseId: houseId)).responseJSON { (res: DataResponse<Any>) in
            var result: HouseViewModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(HouseViewModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getTeamView(teamId: Int, completion: @escaping (TeamSummaryViewModel?, Error?) -> Void) {
        get(at: .getTeamView(teamId: teamId)).responseJSON { (res: DataResponse<Any>) in
            var result: TeamSummaryViewModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(TeamSummaryViewModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func bookmarkHouse(userId: Int, houseId: Int, completion: SendRequestResult?) {
        post(at: .bookmarkHouse(houseId: houseId)).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
        }
    }

    func addReview(userId: Int, review: HouseReviewModel, completion: SendRequestResult?) {
        // TODO
    }

    func changePreference(userId: Int, preference: PreferenceModel, completion: SendRequestResult?) {
        let params = getPreferenceParams(preference)
        post(at: .updatePreference(), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
        }
    }

    func createTeam(userId: Int, houseId: Int, model: HouseTeamSummaryModel, image: UIImage, completion: SendRequestResult?) {
        let params = getTeamParams(model)
        post(at: .updatePreference(), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
            // TODO: send image
        }
    }

    func joinTeam(userId: Int, teamId: Int, completion: SendRequestResult?) {
        post(at: .joinTeam(teamId: teamId)).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
        }
    }

}

extension AlamofireService {
    private func getPreferenceParams(_ preference: PreferenceModel) -> Parameters {
        return Parameters()
    }

    private func getTeamParams(_ model: HouseTeamSummaryModel) -> Parameters {
        return Parameters()
    }
}

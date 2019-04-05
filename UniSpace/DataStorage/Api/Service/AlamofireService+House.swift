//
//  AlamofireService+House.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: HouseService {

    func getHouseSuggestions(completion: @escaping ([HouseSuggestionModel]?, Error?) -> Void) {
        get(at: .getHouseSuggestions).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseSuggestionModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseSuggestionModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getHouseSaved(completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        get(at: .getHouseSaved).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseListModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getHouseHistory(completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        get(at: .getHouseHistory).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseListModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getHouseList(filter: HouseFilterModel, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
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

    func bookmarkHouse(houseId: Int, bookmarked: Bool, completion: SendRequestResult?) {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        params["houseId"] = houseId
        params["bookmarked"] = bookmarked
        post(at: .bookmarkHouse(houseId: houseId), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
        }
    }

    func addReview(review: HouseReviewModel, completion: SendRequestResult?) {
        // TODO
    }

    func changePreference(preference: PreferenceModel, completion: SendRequestResult?) {
        let params = getPreferenceParams(preference)
        post(at: .updatePreference, params: params).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
        }
    }

    func changeTeamPreference(teamId: Int, preference: PreferenceModel, completion: SendRequestResult?) {
        // TODO
    }

    func createTeam(houseId: Int, model: HouseTeamSummaryModel, image: UIImage, completion: SendRequestResult?) {
        let params = getTeamParams(model)
        post(at: .createTeam(houseId: houseId), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: Int? = nil
            if let data = res.result.value { result = self.transform(from: data, type: Int.self) }
            guard let teamId = result else {
                completion?(nil, ServerError.UnknownClassType(object: "Team ID"))
                return
            }
            self.createTeamImage(teamId: teamId, image: image, completion: completion)
        }
    }

    private func createTeamImage(teamId: Int, image: UIImage, completion: SendRequestResult?) {
        var params = Parameters()
        params["teamId"] = teamId
        params["image"] = image
        post(at: .createTeamImage(teamId: teamId), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: Bool? = nil
            if let data = res.result.value { result = self.transform(from: data, type: Bool.self) }
            guard let _ = result else {
                completion?(nil, ServerError.UnknownClassType(object: "Result"))
                return
            }
            completion?(nil, nil)
        }
    }

    func joinTeam(teamId: Int, completion: SendRequestResult?) {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        post(at: .joinTeam(teamId: teamId), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: Bool? = nil
            if let data = res.result.value { result = self.transform(from: data, type: Bool.self) }
            guard let isSuccess = result else {
                completion?(nil, ServerError.UnknownClassType(object: "Result"))
                return
            }
            let msg: String? = (isSuccess ? nil : "Unable to join")
            completion?(msg, res.result.error)
        }
    }

}

extension AlamofireService {
    private func getPreferenceParams(_ preference: PreferenceModel) -> Parameters {
        var params = Parameters()
        params["gender"] = preference.gender?.rawValue
        params["petFree"] = preference.petFree
        params["timeInHouse"] = preference.timeInHouse
        params["personalities"] = preference.personalities
        params["interests"] = preference.interests
        dump(params)
        return params
    }

    private func getTeamParams(_ model: HouseTeamSummaryModel) -> Parameters {
        return Parameters()
    }
}

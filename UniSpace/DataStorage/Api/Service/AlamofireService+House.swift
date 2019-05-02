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
            result?.sort(by: { $0.teamId < $1.teamId })
            completion(result, res.result.error)
        }
    }

    func getHouseSaved(completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        get(at: .getHouseSaved).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseListModel].self, from: data) }
            result?.sort(by: { $0.id < $1.id })
            completion(result, res.result.error)
        }
    }

    func getHouseHistory(completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        get(at: .getHouseHistory).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseListModel].self, from: data) }
            result?.sort(by: { $0.id < $1.id })
            completion(result, res.result.error)
        }
    }

    func getHouseList(filter: HouseFilterModel, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        get(at: .getHouseList(filter: filter)).responseJSON { (res: DataResponse<Any>) in
            var result: [HouseListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([HouseListModel].self, from: data) }
            result?.sort(by: { $0.id < $1.id })
            completion(result, res.result.error)
        }
    }

    func getHouseView(houseId: Int, completion: @escaping (HouseViewModel?, Error?) -> Void) {
        get(at: .getHouseView(houseId: houseId)).responseJSON { (res: DataResponse<Any>) in
            var result: HouseViewModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(HouseViewModel.self, from: data) }
            result?.teams.sort(by: { $0.id < $1.id })
            result?.reviews.sort(by: { $0.date > $1.date })
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
            self.sendRequestStandardHandling(res: res, followUpAction: nil, completion: completion)
        }
    }

    func addReview(houseId: Int, review: HouseReviewModel, completion: SendRequestResult?) {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        params["title"] = review.title
        params["detail"] = review.detail
        params["value"] = review.starRating
        params["cleanliness"] = review.starRating
        params["accuracy"] = review.starRating
        params["communication"] = review.starRating
        post(at: .addReview(houseId: houseId), params: params).responseJSON { (res: DataResponse<Any>) in
            completion?(nil, res.result.error)
        }
    }

    func changePreference(preference: PreferenceModel, completion: SendRequestResult?) {
        let params = getPreferenceParams(preference)
        post(at: .updatePreference, params: params).responseJSON { (res: DataResponse<Any>) in
            completion?(nil, nil)
//            self.sendRequestStandardHandling(res: res, followUpAction: nil, completion: completion)
        }
    }

    func changeTeamPreference(teamId: Int, preference: PreferenceModel, completion: SendRequestResult?) {
        let params = getPreferenceParams(preference)
        put(at: .updateTeamPreference(teamId: teamId), params: params).responseJSON { (res: DataResponse<Any>) in
            completion?(nil, nil)
//            self.sendRequestStandardHandling(res: res, followUpAction: nil, completion: completion)
        }
    }

    func createTeam(houseId: Int, model: HouseTeamSummaryModel, image: UIImage, completion: SendRequestResult?) {
        let params = getTeamParams(houseId, model: model)
        post(at: .createTeam(houseId: houseId), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: Int? = nil
            if let data = res.result.value { result = self.transform(from: data, type: Int.self) }
            guard let teamId = result else {
                completion?(nil, ServerError.UnknownClassType(object: "Team ID"))
                return
            }
            self.createTeamImage(teamId: teamId, preference: model.preference, image: image, completion: completion)
        }
    }

    private func createTeamImage(teamId: Int, preference: PreferenceModel, image: UIImage, completion: SendRequestResult?) {
        easyUpload(
            at: .createTeamImage(teamId: teamId),
            dataFormation: { (multipartFormData) in
                guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                    completion?(nil, ServerError.ImageFormatError(format: "jpeg"))
                    return
                }
                multipartFormData.append(imageData, withName: "photoURL", fileName: "photoURL.jpeg", mimeType: "image/jpeg")
                multipartFormData.append("\(teamId)".data(using: .utf8)!, withName: "teamId")
        }) { (res: DataResponse<Any>) in
            self.sendRequestStandardHandling(res: res, followUpAction: {
                self.changeTeamPreference(teamId: teamId, preference: preference, completion: completion)
            }, completion: completion)
        }
    }

    func joinTeam(teamId: Int, completion: SendRequestResult?) {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        post(at: .joinTeam(teamId: teamId), params: params).responseJSON { (res: DataResponse<Any>) in
            self.sendRequestStandardHandling(res: res, followUpAction: nil, completion: completion)
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
        return params
    }

    private func getTeamParams(_ houseId: Int, model: HouseTeamSummaryModel) -> Parameters {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        params["houseId"] = houseId
        params["title"] = model.title
        params["description"] = model.description
        params["groupSize"] = model.groupSize
        params["duration"] = model.duration
        params["image_url"] = "www.google.com"
        return params
    }
}


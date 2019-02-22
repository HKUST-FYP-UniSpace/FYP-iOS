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
        completion(nil, nil)
    }

    func getHouseSaved(userId: Int, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        completion(nil, nil)
    }

    func getHouseList(userId: Int, filter: HouseFilterModel, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        completion(nil, nil)
    }

    func getHouseView(houseId: Int, completion: @escaping (HouseViewModel?, Error?) -> Void) {
        completion(nil, nil)
    }

    func getTeamView(teamId: Int, completion: @escaping (TeamSummaryViewModel?, Error?) -> Void) {
        completion(nil, nil)
    }

    func bookmarkHouse(userId: Int, houseId: Int, completion: SendRequestResult?) {
        completion?(nil, nil)
    }

    func changePreference(userId: Int, preference: PreferenceModel, completion: SendRequestResult?) {
        completion?(nil, nil)
    }

    func createTeam(userId: Int, model: HouseTeamSummaryModel, image: UIImage, completion: SendRequestResult?) {
        completion?(nil, nil)
    }

}

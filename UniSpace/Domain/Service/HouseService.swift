//
//  HouseService.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

protocol HouseService: class {

    func getHouseSuggestions(completion: @escaping (_ summaries: [HouseSuggestionModel]?, _ error: Error?) -> Void)
    func getHouseSaved(completion: @escaping (_ summaries: [HouseListModel]?, _ error: Error?) -> Void)
    func getHouseHistory(completion: @escaping (_ summaries: [HouseListModel]?, _ error: Error?) -> Void)
    func getHouseList(filter: HouseFilterModel, completion: @escaping (_ summaries: [HouseListModel]?, _ error: Error?) -> Void)
    func getHouseView(houseId: Int, completion: @escaping (_ model: HouseViewModel?, _ error: Error?) -> Void)
    func getTeamView(teamId: Int, completion: @escaping (_ model: TeamSummaryViewModel?, _ error: Error?) -> Void)
    func bookmarkHouse(houseId: Int, bookmarked: Bool, completion: SendRequestResult?)
    func addReview(houseId: Int, review: HouseReviewModel, completion: SendRequestResult?)
    func changePreference(preference: PreferenceModel, completion: SendRequestResult?)
    func changeTeamPreference(teamId: Int, preference: PreferenceModel, completion: SendRequestResult?)
    func createTeam(houseId: Int, model: HouseTeamSummaryModel, image: UIImage, completion: SendRequestResult?)
    func joinTeam(teamId: Int, completion: SendRequestResult?)
}

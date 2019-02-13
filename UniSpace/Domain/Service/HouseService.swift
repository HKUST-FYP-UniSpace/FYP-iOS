//
//  HouseService.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseService: class {

    func getHouseSuggestions(userId: Int, completion: @escaping (_ summaries: [HouseSuggestionModel]?, _ error: Error?) -> Void)
    func getHouseSaved(userId: Int, completion: @escaping (_ summaries: [HouseListModel]?, _ error: Error?) -> Void)
    func getHouseList(userId: Int, filter: HouseFilterModel, completion: @escaping (_ summaries: [HouseListModel]?, _ error: Error?) -> Void)
    func getHouseView(houseId: Int, completion: @escaping (_ model: HouseViewModel?, _ error: Error?) -> Void)
    func getTeamView(teamId: Int, completion: @escaping (_ model: TeamSummaryViewModel?, _ error: Error?) -> Void)
    func bookmarkHouse(userId: Int, houseId: Int, completion: SendRequestResult?)
}

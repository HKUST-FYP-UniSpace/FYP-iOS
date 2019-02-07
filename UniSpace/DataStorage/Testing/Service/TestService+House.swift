//
//  TestService+House.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: HouseService {
    
    func getHouseSuggestions(userId: Int, completion: @escaping ([HouseSuggestionModel]?, Error?) -> Void) {
        var summaries: [HouseSuggestionModel]? = []
        for _ in 0..<20 { summaries?.append(TestHouseSuggestionModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getHouseSaved(userId: Int, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        var summaries: [HouseListModel]? = []
        for _ in 0..<4 { summaries?.append(TestHouseListModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getHouseList(userId: Int, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        var summaries: [HouseListModel]? = []
        for _ in 0..<20 { summaries?.append(TestHouseListModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getHouseView(houseId: Int, completion: @escaping (HouseViewModel?, Error?) -> Void) {
        var teams: [HouseTeamSummaryModel] = []
        for _ in 0..<4 { teams.append(TestHouseTeamSummaryModel().toModel()) }
        let model = HouseViewModel(titleView: TestHouseListModel().toModel(), teams: teams)
        delay { completion(model, nil) }
    }

}

//
//  TestHouseTeamSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestHouseTeamSummaryModel: HouseTeamSummary {

    var id: Int
    var title: String
    var price: Int
    var duration: String
    var subtitle: String
    var groupSize: Int
    var occupiedCount: Int

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = ["Team Awesome", "Warmest team you can find", "Funny Rommies!"].randomElement()!
        price = Int.random(in: 50..<200) * 100
        duration = ["3 months", "Half year", "1 year", "2 years"].randomElement()!
        subtitle = ["Boys / Pet-free / Casual drinkers", "Girls / Pet-friendly / Talk to us!"].randomElement()!
        groupSize = Int.random(in: 2..<6)
        occupiedCount = Int.random(in: 1..<groupSize)
    }

    func toModel() -> HouseTeamSummaryModel {
        let model = HouseTeamSummaryModel()
        model.id = id
        model.title = title
        model.price = price
        model.duration = duration
        model.subtitle = subtitle
        model.groupSize = groupSize
        model.occupiedCount = occupiedCount
        return model
    }
}

//
//  TestOwnerHouseSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestOwnerHouseSummaryModel: OwnerHouseSummary {

    var id: Int
    var createTime: Double
    var title: String
    var address: String
    var price: Int
    var size: Int
    var numberOfViews: Int
    var numberOfBookmarks: Int
    var starRating: Int
    var arrangingTeamCount: Int
    var formingTeamCount: Int
    var houseStatus: HouseStatus

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        createTime = DateManager.shared.randomTime(90)
        title = Lorem.words()
        address = Lorem.sentence()
        price = Int.random(in: 50..<200) * 100
        size = Int.random(in: 500..<1500)
        numberOfViews = Int.random(in: 500..<3000)
        numberOfBookmarks = Int.random(in: 100..<1000)
        starRating = Int.random(in: 0..<6)
        arrangingTeamCount = Int.random(in: 0..<10)
        formingTeamCount = Int.random(in: 0..<10)
        houseStatus = HouseStatus.allCases.randomElement()!
    }

    func toModel() -> OwnerHouseSummaryModel {
        let model = OwnerHouseSummaryModel()
        model.id = id
        model.createTime = createTime
        model.title = title
        model.address = address
        model.price = price
        model.size = size
        model.numberOfViews = numberOfViews
        model.numberOfBookmarks = numberOfBookmarks
        model.starRating = starRating
        model.arrangingTeamCount = arrangingTeamCount
        model.formingTeamCount = formingTeamCount
        model.houseStatus = houseStatus
        return model
    }
}

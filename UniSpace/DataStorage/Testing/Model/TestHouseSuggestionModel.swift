//
//  TestHouseSuggestionModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestHouseSuggestionModel: HouseSuggestion {

    var houseId: Int
    var teamId: Int
    var title: String
    var preference: PreferenceModel
    var groupSize: Int
    var occupiedCount: Int
    var photoURL: String
    var duration: String

    required init() {
        houseId = DataStore.shared.randomInt(length: 8)
        teamId = DataStore.shared.randomInt(length: 8)
        title = Lorem.words()
        preference = TestPreferenceModel().toModel()
        groupSize = Int.random(in: 2..<6)
        occupiedCount = Int.random(in: 1..<groupSize)
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_L, ratio: 0.75)
        duration = ["3 months", "6 months", "1 year", "2 years"].randomElement()!
    }

    func toModel() -> HouseSuggestionModel {
        let model = HouseSuggestionModel()
        model.houseId = houseId
        model.teamId = teamId
        model.title = title
        model.preference = preference
        model.groupSize = groupSize
        model.occupiedCount = occupiedCount
        model.photoURL = photoURL
        model.duration = duration
        return model
    }
}

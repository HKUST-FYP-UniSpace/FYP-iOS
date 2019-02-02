//
//  TestHouseSuggestionModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestHouseSuggestionModel: HouseSuggestion {

    var id: Int
    var title: String
    var subTitle: String
    var photoURL: String
    var duration: String

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = "Team Awesome"
        subTitle = "Boys / Pet-free / Casual drinker"
        photoURL = Constants.dummyPhotoURL(400, ratio: 0.75)
        duration = ["3 months", "6 months", "1 year", "2 years"].randomElement()!
    }

    func toModel() -> HouseSuggestionModel {
        let model = HouseSuggestionModel()
        model.id = id
        model.title = title
        model.subTitle = subTitle
        model.photoURL = photoURL
        model.duration = duration
        return model
    }
}

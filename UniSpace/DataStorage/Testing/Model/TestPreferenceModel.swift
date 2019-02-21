//
//  TestPreferenceModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestPreferenceModel: Preference {

    var id: Int
    var gender: Gender?
    var petFree: Bool?
    var timeInHouse: String?
    var personalities: [String]?
    var interests: [String]?

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        gender = Gender.allCases.randomElement()!
        petFree = Bool.random()
        timeInHouse = PreferenceOptions.timeInHouse.randomElement()

        var personalities: Set<String> = []
        while personalities.count != 4 {
            personalities.insert(PreferenceOptions.personalities.randomElement()!)
        }
        self.personalities = Array(personalities)

        var interests: Set<String> = []
        while interests.count != 4 {
            interests.insert(PreferenceOptions.interests.randomElement()!)
        }
        self.interests = Array(interests)
    }

    func toModel() -> PreferenceModel {
        let model = PreferenceModel()
        model.id = id
        model.gender = gender
        model.petFree = petFree
        model.timeInHouse = timeInHouse
        model.personalities = personalities
        model.interests = interests
        return model
    }
}

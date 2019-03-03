//
//  PreferenceModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 19/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class PreferenceModel: Decodable, ListDiffable, Preference {

    var id: Int = 0
    var gender: Gender? = nil
    var petFree: Bool? = nil
    var timeInHouse: String? = nil
    var personalities: [String]? = nil
    var interests: [String]? = nil

    init() {}

    enum CodingKeys: String, CodingKey {
        case id
        case gender
        case petFree
        case timeInHouse
        case personalities
        case interests
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        let genderInt = try container.decode(Int.self, forKey: .gender)
        gender = Gender(rawValue: genderInt)
        petFree = try container.decode(Bool.self, forKey: .petFree)
        timeInHouse = try container.decode(String.self, forKey: .timeInHouse)
        personalities = try container.decode([String].self, forKey: .personalities)
        interests = try container.decode([String].self, forKey: .interests)
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? PreferenceModel else { return false }
        return self.id == object.id
    }

    func allSet() -> Bool {
        return petFree != nil
            && timeInHouse != nil
            && personalities != nil
            && interests != nil
    }

    func getTextForm() -> String {
        var texts: [String] = []
        if let gender = gender { texts.append(gender.text) }
        if let petFree = petFree {
            if petFree { texts.append("Pet-free") }
        }

        if let personalities = personalities, let personality = personalities.first { texts.append(personality) }
        if let interests = interests, let interest = interests.first { texts.append(interest) }
        return texts.joined(separator: " / ")
    }

}

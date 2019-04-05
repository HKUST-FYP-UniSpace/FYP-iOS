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

    var id: Int = DataStore.shared.randomInt(length: 8)
    var gender: Gender? = nil
    var petFree: Bool? = false
    var timeInHouse: String? = nil
    var personalities: [String]? = nil
    var interests: [String]? = nil

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
        decode(container, &gender, type: Gender?.self, forKey: .gender)
        decode(container, &petFree, type: Bool?.self, forKey: .petFree)
        decode(container, &timeInHouse, type: String?.self, forKey: .timeInHouse)
        decode(container, &personalities, type: [String]?.self, forKey: .personalities)
        decode(container, &interests, type: [String]?.self, forKey: .interests)
    }

    private func decode<T>(_ container: KeyedDecodingContainer<CodingKeys>, _ variable: inout T, type: T.Type, forKey key: CodingKeys) where T: Decodable {
        if let _variable = try? container.decode(type, forKey: key) {
            variable = _variable
        }
    }

    init() {}

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

//
//  HouseSuggestionModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseSuggestionModel: Decodable, ListDiffable, HouseSuggestion {

    var houseId: Int = 0
    var teamId: Int = 0
    var title: String = ""
    var preference: PreferenceModel = PreferenceModel()
    var groupSize: Int = 0
    var occupiedCount: Int = 0
    var photoURL: String = ""
    var duration: String = ""

    enum CodingKeys: String, CodingKey {
        case houseId
        case teamId
        case title
        case preference
        case groupSize
        case occupiedCount
        case photoURL = "photoURLs"
        case duration
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &houseId, type: Int.self, forKey: .houseId)
        decode(container, &teamId, type: Int.self, forKey: .teamId)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &preference, type: PreferenceModel.self, forKey: .preference)
        decode(container, &groupSize, type: Int.self, forKey: .groupSize)
        decode(container, &occupiedCount, type: Int.self, forKey: .occupiedCount)
        var photoURLs: [String] = []
        decode(container, &photoURLs, type: [String].self, forKey: .photoURL)
        photoURL = photoURLs.first ?? ""
        var durationInt: Int = 0
        decode(container, &durationInt, type: Int.self, forKey: .duration)
        duration = durationInt <= 1 ? "\(durationInt) year" : "\(durationInt) years"
    }

    private func decode<T>(_ container: KeyedDecodingContainer<CodingKeys>, _ variable: inout T, type: T.Type, forKey key: CodingKeys) where T: Decodable {
        if let _variable = try? container.decode(type, forKey: key) {
            variable = _variable
        }
    }

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return teamId as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseSuggestionModel else { return false }
        return self.teamId == object.teamId
    }

}

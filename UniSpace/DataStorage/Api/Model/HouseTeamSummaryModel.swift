//
//  HouseTeamSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseTeamSummaryModel: Decodable, ListDiffable, HouseTeamSummary {

    var id: Int = 0
    var title: String = ""
    var price: Int = 0
    var duration: String = ""
    var preference: PreferenceModel = PreferenceModel()
    var description: String = ""
    var groupSize: Int = 0
    var occupiedCount: Int = 0
    var photoURL: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case duration
        case preference
        case description
        case groupSize
        case occupiedCount
        case photoURL
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &price, type: Int.self, forKey: .price)

        var durationYear = 0
        decode(container, &durationYear, type: Int.self, forKey: .duration)
        duration = durationYear == 1 ? "1 year" : "\(durationYear) years"
        
        decode(container, &preference, type: PreferenceModel.self, forKey: .preference)
        decode(container, &description, type: String.self, forKey: .description)
        decode(container, &groupSize, type: Int.self, forKey: .groupSize)
        decode(container, &occupiedCount, type: Int.self, forKey: .occupiedCount)
        decode(container, &photoURL, type: String.self, forKey: .photoURL)
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
        guard let object = object as? HouseTeamSummaryModel else { return false }
        return self.id == object.id
    }

    func allSet() -> Bool {
        return title != ""
            && description != ""
            && groupSize != 0
    }

}

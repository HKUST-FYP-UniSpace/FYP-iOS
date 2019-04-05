//
//  OwnerHouseSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class OwnerHouseSummaryModel: Decodable, ListDiffable, OwnerHouseSummary {

    var id: Int = 0
    var createTime: Double = 0
    var title: String = ""
    var address: String = ""
    var price: Int = 0
    var size: Int = 0
    var numberOfViews: Int = 0
    var numberOfBookmarks: Int = 0
    var starRating: Double = 0
    var arrangingTeamCount: Int = 0
    var formingTeamCount: Int = 0
    var houseStatus: HouseStatus = .Reveal

    enum CodingKeys: String, CodingKey {
        case id
        case createTime
        case title
        case address
        case price
        case size
        case numberOfViews
        case numberOfBookmarks
        case starRating
        case arrangingTeamCount
        case formingTeamCount
        case houseStatus
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &createTime, type: Double.self, forKey: .createTime)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &address, type: String.self, forKey: .address)
        decode(container, &price, type: Int.self, forKey: .price)
        decode(container, &size, type: Int.self, forKey: .size)
        decode(container, &numberOfViews, type: Int.self, forKey: .numberOfViews)
        decode(container, &numberOfBookmarks, type: Int.self, forKey: .numberOfBookmarks)
        decode(container, &starRating, type: Double.self, forKey: .starRating)
        decode(container, &arrangingTeamCount, type: Int.self, forKey: .arrangingTeamCount)
        decode(container, &formingTeamCount, type: Int.self, forKey: .formingTeamCount)
        decode(container, &houseStatus, type: HouseStatus.self, forKey: .houseStatus)
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
        guard let object = object as? OwnerHouseSummaryModel else { return false }
        return self.id == object.id
    }

}

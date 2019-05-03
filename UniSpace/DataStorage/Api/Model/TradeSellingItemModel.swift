//
//  TradeSellingItemModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class TradeSellingItemModel: Decodable, ListDiffable, TradeSellingItem {

    var id: Int = 0
    var title: String = ""
    var price: Int = 0
    var views: Int = 0
    var photoURL: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case views
        case photoURL
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &price, type: Int.self, forKey: .price)
        decode(container, &views, type: Int.self, forKey: .views)
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
        guard let object = object as? TradeSellingItemModel else { return false }
        return self.id == object.id
    }

}

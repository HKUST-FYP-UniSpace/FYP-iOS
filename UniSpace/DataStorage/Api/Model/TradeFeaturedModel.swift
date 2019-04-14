//
//  TradeFeaturedModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class TradeFeaturedModel: Decodable, ListDiffable, TradeFeatured {

    var id: Int = 0
    var title: String = ""
    var location: String = ""
    var transactionType: String = ""
    var price: Int = 0
    var status: String = ""
    var detail: String = ""
    var isBookmarked: Bool = false
    var photoURLs: [String] = []

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case transactionType
        case price
        case status
        case detail = "description"
        case isBookmarked
        case photoURLs
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &location, type: String.self, forKey: .location); location = "Discovery Park, Tsuen Wan"
        decode(container, &transactionType, type: String.self, forKey: .transactionType)
        decode(container, &price, type: Int.self, forKey: .price)
        decode(container, &status, type: String.self, forKey: .status)
        decode(container, &detail, type: String.self, forKey: .detail)
        decode(container, &isBookmarked, type: Bool.self, forKey: .isBookmarked)
        decode(container, &photoURLs, type: [String].self, forKey: .photoURLs)
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
        guard let object = object as? TradeFeaturedModel else { return false }
        return self.id == object.id
    }

    func allSet() -> Bool {
        return !title.isEmpty
            && !location.isEmpty
            && price != 0
            && !detail.isEmpty
    }

}

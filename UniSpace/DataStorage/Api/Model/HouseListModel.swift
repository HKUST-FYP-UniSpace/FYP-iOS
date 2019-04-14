//
//  HouseListModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseListModel: Decodable, ListDiffable, HouseList {

    var id: Int = 0
    var title: String = ""
    var price: Int = 0
    var size: Int = 0
    var starRating: Double = 0
    var subtitle: String = ""
    var address: String = ""
    var isBookmarked: Bool = false
    var photoURLs: [String] = []
    var rooms: Int = 0
    var beds: Int = 0
    var toilets: Int = 0


    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case size
        case starRating
        case subtitle
        case address
        case isBookmarked
        case photoURLs
        case rooms
        case beds
        case toilets
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &price, type: Int.self, forKey: .price)
        decode(container, &size, type: Int.self, forKey: .size)
        decode(container, &starRating, type: Double.self, forKey: .starRating)
        decode(container, &subtitle, type: String.self, forKey: .subtitle)
        decode(container, &address, type: String.self, forKey: .address)
        decode(container, &isBookmarked, type: Bool.self, forKey: .isBookmarked)
        decode(container, &photoURLs, type: [String].self, forKey: .photoURLs)
        decode(container, &rooms, type: Int.self, forKey: .rooms); rooms = Int.random(in: 1...6)
        decode(container, &beds, type: Int.self, forKey: .beds); beds = Int.random(in: 1...6)
        decode(container, &toilets, type: Int.self, forKey: .toilets); toilets = Int.random(in: 1...6)
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
        guard let object = object as? HouseListModel else { return false }
        return self.id == object.id
    }

    func allSet() -> Bool {
       return !title.isEmpty
        && !address.isEmpty
        && !subtitle.isEmpty
        && price != 0
        && size != 0
        && rooms != 0
        && beds != 0
        && toilets != 0
    }

}

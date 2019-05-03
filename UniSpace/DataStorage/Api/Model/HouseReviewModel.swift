//
//  HouseReviewModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 7/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseReviewModel: Decodable, ListDiffable, HouseReview {
    
    var id: Int = 0
    var username: String = ""
    var title: String = ""
    var date: Double = 0
    var detail: String = ""
    var starRating: Double = 0
    var ownerId: Int = 0
    var ownerComment: String = ""
    var photoURL: String = ""

    // disset star rating
    var value: Double = 0
    var cleanliness: Double = 0
    var accuracy: Double = 0
    var communication: Double = 0

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case title
        case date
        case detail
        case starRating
        case ownerId
        case ownerComment
        case photoURL
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &username, type: String.self, forKey: .username)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &date, type: Double.self, forKey: .date)
        decode(container, &detail, type: String.self, forKey: .detail)
        decode(container, &starRating, type: Double.self, forKey: .starRating)
        decode(container, &ownerId, type: Int.self, forKey: .ownerId)
        decode(container, &ownerComment, type: String.self, forKey: .ownerComment)
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
        guard let object = object as? HouseReviewModel else { return false }
        return self.id == object.id
    }

    func readableDate() -> String {
        let date = Date(timeIntervalSince1970: self.date)
        return DateManager.shared.convertToDateFormat(date: date)
    }

}

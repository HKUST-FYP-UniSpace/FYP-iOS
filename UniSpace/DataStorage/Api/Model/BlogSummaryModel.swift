//
//  BlogSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class BlogSummaryModel: Decodable, ListDiffable, BlogSummary {

    var id: Int = 0
    var title: String = ""
    var subtitle: String = ""
    var detail: String = ""
    var photoURL: String = ""
    var time: Double = 0

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case detail
        case photoURL
        case time
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &subtitle, type: String.self, forKey: .subtitle)
        decode(container, &detail, type: String.self, forKey: .detail)
        decode(container, &photoURL, type: String.self, forKey: .photoURL)
        decode(container, &time, type: Double.self, forKey: .time)
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
        guard let object = object as? BlogSummaryModel else { return false }
        return self.id == object.id
    }

}

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
    var subTitle: String = ""
    var photoURL: String = ""

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return "\(id)" as NSString
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? MessageSummaryModel else { return false }
        return self.id == object.id
    }

}

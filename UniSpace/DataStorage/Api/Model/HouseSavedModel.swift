//
//  HouseSavedModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseSavedModel: Decodable, ListDiffable, HouseSaved {

    var id: Int = 0
    var title: String = ""
    var price: Int = 0
    var size: Int = 0
    var starRating: Int = 0
    var photoURL: String = ""

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return "\(id)" as NSString
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseSavedModel else { return false }
        return self.id == object.id
    }

}

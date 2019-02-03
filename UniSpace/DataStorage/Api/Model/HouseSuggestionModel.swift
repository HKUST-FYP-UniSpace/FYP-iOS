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

    var id: Int = 0
    var title: String = ""
    var subTitle: String = ""
    var photoURL: String = ""
    var duration: String = ""

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseSuggestionModel else { return false }
        return self.id == object.id
    }

}

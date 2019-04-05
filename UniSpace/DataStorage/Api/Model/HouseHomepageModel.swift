//
//  HouseHomepageModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseHomepageModel: ListDiffable {

    var id: Int = DataStore.shared.randomInt(length: 8)
    var suggestions: [HouseSuggestionModel] = []
    var saved: [HouseListModel] = []

    init() {
        id = DataStore.shared.randomInt(length: 8)
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseHomepageModel else { return false }
        return self.id == object.id
    }

}

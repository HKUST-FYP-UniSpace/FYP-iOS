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

    var houseId: Int = 0
    var teamId: Int = 0
    var title: String = ""
    var subtitle: String = ""
    var groupSize: Int = 0
    var occupiedCount: Int = 0
    var photoURL: String = ""
    var duration: String = ""

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return teamId as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseSuggestionModel else { return false }
        return self.teamId == object.teamId
    }

}

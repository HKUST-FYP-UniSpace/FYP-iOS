//
//  HouseTeamSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseTeamSummaryModel: Decodable, ListDiffable, HouseTeamSummary {

    var id: Int = 0
    var title: String = ""
    var price: Int = 0
    var duration: String = ""
    var preference: PreferenceModel = PreferenceModel()
    var description: String = ""
    var groupSize: Int = 0
    var occupiedCount: Int = 0
    var photoURL: String = ""

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseTeamSummaryModel else { return false }
        return self.id == object.id
    }

}

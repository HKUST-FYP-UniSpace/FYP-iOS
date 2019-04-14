//
//  OwnerTeamsModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 19/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class OwnerTeamsModel: Decodable, ListDiffable {

    var id: Int = DataStore.shared.randomInt(length: 8)
    var teams: [HouseTeamSummaryModel]
    var reviews: [HouseReviewModel]

    convenience init() {
        self.init(teams: [], reviews: [])
    }

    init(teams: [HouseTeamSummaryModel], reviews: [HouseReviewModel]) {
        id = DataStore.shared.randomInt(length: 8)
        self.teams = teams
        self.reviews = reviews
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? OwnerTeamsModel else { return false }
        return self.id == object.id
    }

}

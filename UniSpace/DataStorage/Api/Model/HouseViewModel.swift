//
//  HouseViewModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseViewModel: Decodable, ListDiffable {

    var id: Int
    var titleView: HouseListModel?
    var teams: [HouseTeamSummaryModel]

    convenience init() {
        self.init(titleView: nil, teams: [])
    }

    init(titleView: HouseListModel?, teams: [HouseTeamSummaryModel]) {
        id = DataStore.shared.randomInt(length: 8)
        self.titleView = titleView
        self.teams = teams
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseViewModel else { return false }
        return self.id == object.id
    }

}

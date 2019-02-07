//
//  TeamSummaryViewModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class TeamSummaryViewModel: Decodable, ListDiffable {

    var id: Int
    var teamView: HouseTeamSummaryModel?
    var teamMembers: [TeamMemberModel]

    convenience init() {
        self.init(teamView: nil, teamMembers: [])
    }

    init(teamView: HouseTeamSummaryModel?, teamMembers: [TeamMemberModel]) {
        id = DataStore.shared.randomInt(length: 8)
        self.teamView = teamView
        self.teamMembers = teamMembers
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? TeamSummaryViewModel else { return false }
        return self.id == object.id
    }

}

//
//  TestTeamMemberModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestTeamMemberModel: TeamMember {

    var id: Int
    var name: String
    var role: TeamMemberRole
    var photoURL: String

    required init(name: String, role: TeamMemberRole) {
        id = DataStore.shared.randomInt(length: 8)
        self.name = name
        self.role = role
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_S)
    }

    func toModel() -> TeamMemberModel {
        let model = TeamMemberModel()
        model.id = id
        model.name = name
        model.role = role
        model.photoURL = photoURL
        return model
    }
}

//
//  TeamMemberModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class TeamMemberModel: Decodable, ListDiffable, TeamMember {

    var id: Int = 0
    var name: String = ""
    var role: TeamMemberRole = .Member
    var photoURL: String = ""

    init() {}

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case role
        case photoURL
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let roleInt = try container.decode(Int.self, forKey: .role)
        role = TeamMemberRole(rawValue: roleInt) ?? .Member
        photoURL = try container.decode(String.self, forKey: .photoURL)
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? TeamMemberModel else { return false }
        return self.id == object.id
    }

}

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

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case role
        case photoURL
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &name, type: String.self, forKey: .name)
        decode(container, &role, type: TeamMemberRole.self, forKey: .role)
        decode(container, &photoURL, type: String.self, forKey: .photoURL)
    }

    private func decode<T>(_ container: KeyedDecodingContainer<CodingKeys>, _ variable: inout T, type: T.Type, forKey key: CodingKeys) where T: Decodable {
        if let _variable = try? container.decode(type, forKey: key) {
            variable = _variable
        }
    }

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? TeamMemberModel else { return false }
        return self.id == object.id
    }

}

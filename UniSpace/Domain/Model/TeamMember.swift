//
//  TeamMember.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

enum TeamMemberRole: Int {
    case Leader = 0
    case Member

    var text: String {
        switch self {
        case .Leader: return "Leader"
        case .Member: return "Member"
        }
    }
}

protocol TeamMember: PhotoShowable {

    var id: Int { get set }
    var name: String { get set }
    var role: TeamMemberRole { get set }
    var photoURL: String { get set }

}

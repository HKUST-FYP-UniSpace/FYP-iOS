//
//  User.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

protocol User: UserProfile {
    
    var id: Int { get set }
    var username: String { get set }
    var preference: PreferenceModel { get set }
    var photoURL: String { get set }

    var contact: String { get set }
    var selfIntro: String { get set }
    var name: String { get set }
    var email: String { get set }
    var gender: Gender { get set }
    var userType: UserType { get set }
    var isActive: Bool { get set }
    var createTime: Double { get set }
    var verified: Bool { get set }
    
}

enum UserType: Int {
    case Tenant = 0
    case Owner

    var text: String {
        switch self {
        case .Tenant: return "Student Tenant"
        case .Owner: return "House Owner"
        }
    }
}

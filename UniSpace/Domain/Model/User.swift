//
//  User.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

protocol User {
    
    var id: Int { get set }
    var email: String { get set }
    var username: String { get set }
    var name: String { get set }
    var role: Int { get set }
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

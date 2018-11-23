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
    var createTime: String { get set }
    var verified: Bool { get set }
    
}

enum UserType: String {
    case Tenant = "Student Tenant"
    case Owner = "House Owner"
}

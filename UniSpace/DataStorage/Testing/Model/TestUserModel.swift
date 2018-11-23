//
//  TestUserModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

class TestUserModel: User {
    
    var id: Int
    var email: String
    var username: String
    var name: String
    var role: Int
    var isActive: Bool
    var createTime: String
    var verified: Bool
    
    required init(id: Int, email: String, username: String, name: String, role: UserType) {
        createTime = DateManager.shared.getCurrentDateAndTime()
        isActive = true
        verified = false
        
        self.init()
        self.id = id
        self.email = email
        self.username = username
        self.name = name
        self.role = role.hashValue
    }
    
}

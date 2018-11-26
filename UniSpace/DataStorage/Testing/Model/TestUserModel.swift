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
    
    required init(email: String, username: String, name: String, role: UserType) {
        id = Int.random(in: 0 ..< 1000)
        createTime = DateManager.shared.getCurrentDateAndTime()
        isActive = true
        verified = false
        
        self.email = email
        self.username = username
        self.name = name
        self.role = role.hashValue
    }
    
    func toUserModel() -> UserModel {
        let user = UserModel()
        id = user.id
        email = user.email
        username = user.username
        name = user.name
        role = user.role
        isActive = user.isActive
        createTime = user.createTime
        verified = user.verified
        return user
    }
    
}

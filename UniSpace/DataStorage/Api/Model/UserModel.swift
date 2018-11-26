//
//  UserModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

class UserModel: Decodable, User {

    var id: Int = 0
    var email: String = ""
    var username: String = ""
    var name: String = ""
    var role: Int = 0
    var isActive: Bool = false
    var createTime: String = ""
    var verified: Bool = false
    
    init() {}

}

//
//  UserModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import ObjectMapper

class UserModel: Mappable, User {

    var id: Int = 0
    var email: String = ""
    var username: String = ""
    var name: String = ""
    var role: Int = 0
    var isActive: Bool = false
    var createTime: String = ""
    var verified: Bool = false
    
    init() {}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.email <- map["email"]
        self.username <- map["username"]
        self.name <- map["name"]
        self.role <- map["role"]
        self.isActive <- map["isActive"]
        self.createTime <- map["createTime"]
        self.verified <- map["verified"]
    }

}

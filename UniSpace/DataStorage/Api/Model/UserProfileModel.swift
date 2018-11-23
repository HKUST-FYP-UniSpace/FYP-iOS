//
//  UserProfileModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import ObjectMapper

class UserProfileModel: Mappable, UserProfile {
    
    var id: Int = 0
    var username: String = ""
    var pictureUrl: String = ""
    
    init() {}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.username <- map["username"]
        self.pictureUrl <- map["pictureUrl"]
    }
    
}

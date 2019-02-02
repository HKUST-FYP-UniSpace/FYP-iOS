//
//  UserProfileModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//


class UserProfileModel: Decodable, UserProfile {
    
    var id: Int = 0
    var username: String = ""
    var photoURL: String = ""
    
    init() {}
    
}

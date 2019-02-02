//
//  TestUserProfileModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

class TestUserProfileModel: UserProfile {
    
    var id: Int
    var username: String
    var photoURL: String
    
    required init(id: Int, username: String, photoURL: URL?) {
        self.id = id
        self.username = username
        self.photoURL = photoURL?.absoluteString ?? ""
    }
    
}

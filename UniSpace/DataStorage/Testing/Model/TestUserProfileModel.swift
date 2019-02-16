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
    
    required init(username: String) {
        id = DataStore.shared.randomInt(length: 8)
        self.username = username
        self.photoURL = Constants.dummyPhotoURL(Constants.cardWidth_M, ratio: 1)
    }

    func toModel() -> UserProfileModel {
        let user = UserProfileModel()
        user.id = id
        user.username = username
        user.photoURL = photoURL
        return user
    }
    
}

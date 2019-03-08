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
    var username: String
    var preference: PreferenceModel
    var photoURL: String
    var email: String
    var familyName: String
    var givenName: String
    var role: UserType
    var isActive: Bool
    var createTime: Double
    var verified: Bool
    
    required init(email: String, username: String, name: String, role: UserType) {
        id = DataStore.shared.randomInt(length: 8)
        self.username = username
        self.preference = TestPreferenceModel().toModel()
        self.photoURL = Constants.dummyPhotoURL(Constants.cardWidth_M, ratio: 1)

        self.email = email
        self.familyName = ""
        self.givenName = ""
        self.role = role
        isActive = true
        createTime = DateManager.shared.getCurrentDate().timeIntervalSince1970
        verified = false
    }
    
    func toUserModel() -> UserModel {
        let model = UserModel()
        model.id = id
        model.username = username
        model.preference = preference
        model.photoURL = photoURL
        model.email = email
        model.familyName = familyName
        model.givenName = givenName
        model.role = role
        model.isActive = isActive
        model.createTime = createTime
        model.verified = verified
        return model
    }
    
}

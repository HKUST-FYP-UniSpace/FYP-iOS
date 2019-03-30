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
    var contact: String
    var selfIntro: String
    var name: String
    var email: String
    var gender: Gender?
    var userType: UserType
    var isActive: Bool
    var createTime: Double
    var verified: Bool
    
    required init(email: String, username: String, name: String, role: UserType, verified: Bool, hasPreference: Bool) {
        self.id = DataStore.shared.randomInt(length: 8)
        self.username = username
        self.preference = hasPreference ? TestPreferenceModel().toModel() : PreferenceModel()
        self.photoURL = Constants.dummyPhotoURL(Constants.cardWidth_M, ratio: 1)

        self.contact = ""
        self.selfIntro = ""
        self.name = name
        self.email = email
        self.userType = role
        self.isActive = true
        self.createTime = DateManager.shared.getCurrentDate().timeIntervalSince1970
        self.verified = verified
    }
    
    func toUserModel() -> UserModel {
        let model = UserModel()
        model.id = id
        model.username = username
        model.preference = preference
        model.photoURL = photoURL
        model.contact = contact
        model.selfIntro = selfIntro
        model.name = name
        model.email = email
        model.gender = gender
        model.userType = userType
        model.isActive = isActive
        model.createTime = createTime
        model.verified = verified
        return model
    }
    
}

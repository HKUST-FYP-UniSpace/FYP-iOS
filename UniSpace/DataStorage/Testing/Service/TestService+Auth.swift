//
//  TestAuthService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: AuthService {
        
    func authorize(completion: @escaping (UserModel?, Error?) -> Void) {
        if !TestService.canLogin {
            delay { completion(nil, TestingAPIError.LoginFailed) }
            return
        }
        
        let user = TestUserModel(email: "123@test.com", username: "Test user", name: "123", role: .Tenant)
        DataStore.shared.user = user.toUserModel()
        delay { completion(DataStore.shared.user, nil) }
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (UserModel?, Error?) -> Void) {
        let user = TestUserModel(email: email, username: username, name: password, role: userType)
        DataStore.shared.user = user.toUserModel()
        delay { completion(DataStore.shared.user, nil) }
    }
    
    func verify(userId: Int, code: String, completion: @escaping (UserModel?, Error?) -> Void) {
        TestService.canLogin = true
        DataStore.shared.user?.verified = true
        delay { completion(DataStore.shared.user, nil) }
    }
    
}

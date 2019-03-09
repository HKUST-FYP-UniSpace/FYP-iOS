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
        delay { completion(DataStore.shared.user, nil) }
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (UserModel?, Error?) -> Void) {
        let user = TestUserModel(email: email, username: name, role: userType, verified: false, hasPreference: false).toUserModel()
        DataStore.shared.user = user
        delay { completion(user, nil) }
    }
    
    func verify(userId: Int, code: String, completion: @escaping (UserModel?, Error?) -> Void) {
        DataStore.shared.user?.verified = true
        delay { completion(DataStore.shared.user, nil) }
    }

    func existUsername(username: String, completion: @escaping (_ exist: Bool?, _ error: Error?) -> Void) {
        delay { completion(false, nil) }
    }
    
}

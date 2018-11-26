//
//  TestAuthService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: AuthService {
        
    func authorize(completion: @escaping (UserModel?, Error?) -> ()) {
        completion(DataStore.shared.user, nil)
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (UserModel?, Error?) -> ()) {
        let user = TestUserModel(email: email, username: username, name: password, role: userType)
        DataStore.shared.user = user.toUserModel()
        completion(DataStore.shared.user, nil)
    }
    
    func verify(userId: Int, code: String, completion: @escaping (UserModel?, Error?) -> ()) {
        DataStore.shared.user?.verified = true
        completion(DataStore.shared.user, nil)
    }
    
}

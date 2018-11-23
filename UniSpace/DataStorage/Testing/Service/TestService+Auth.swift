//
//  TestAuthService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: AuthService {
        
    func authorize(completion: @escaping (User?, Error?) -> ()) {
        completion(DataStore.shared.userInfo, nil)
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (User?, Error?) -> ()) {
        completion(DataStore.shared.userInfo, nil)
    }
    
    func verify(userId: Int, code: String, completion: @escaping (User?, Error?) -> ()) {
        completion(DataStore.shared.userInfo, nil)
    }
    
}

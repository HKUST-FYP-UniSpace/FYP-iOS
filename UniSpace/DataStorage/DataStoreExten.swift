//
//  DataStore+Auth.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension DataStore {
    
    func authorize(completion: @escaping (UserModel?, Error?) -> ()) {
        Service().authorize(completion: completion)
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (UserModel?, Error?) -> ()) {
        Service().register(userType: userType, username: username, name: name, email: email, password: password, completion: completion)
    }
    
    func verify(userId: Int, code: String, completion: @escaping (UserModel?, Error?) -> ()) {
        Service().verify(userId: userId, code: code, completion: completion)
    }
    
    func getUserProfile(userId: Int, completion: @escaping (UserProfileModel?, Error?) -> ()) {
        Service().getUserProfile(userId: userId, completion: completion)
    }
    
}

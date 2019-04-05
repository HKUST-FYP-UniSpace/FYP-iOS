//
//  AuthService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

protocol AuthService: class {
    
    func authorize(completion: @escaping (_ user: UserModel?, _ error: Error?) -> Void)
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (_ user: UserModel?, _ error: Error?) -> Void)
    
    func verify(code: String, completion: @escaping (_ user: UserModel?, _ error: Error?) -> Void)

    func existUsername(username: String, completion: @escaping (_ exist: Bool?, _ error: Error?) -> Void)
    
}

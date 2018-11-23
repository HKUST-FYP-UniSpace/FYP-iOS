//
//  AuthService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

protocol AuthService: class {
    
    func authorize(completion: @escaping (_ user: User?, _ error: Error?) -> ())
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> ())
    
    //  or no userId is needed bc of the token
    func verify(userId: Int, code: String, completion: @escaping (_ user: User?, _ error: Error?) -> ())
    
}

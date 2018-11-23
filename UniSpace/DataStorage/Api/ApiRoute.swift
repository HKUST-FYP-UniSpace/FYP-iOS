//
//  ApiRoute.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

enum ApiRoute { case
    
    authorize,
    register,
    verify(userId: Int),
    getUserProfile(userId: Int)
    
    var path: String {
        switch self {
        case .authorize:
            return "users/login"
            
        case .register:
            return "users/register"
            
        case .verify(let userId):
            return "users/verify/\(userId)"
            
        case .getUserProfile(let userId):
            return "users/profile/\(userId)"
            
        default:
            return ""
        }
        
    }
    
    func url() -> String {
        let host = "http://localhost:8080/api-mobile/v1"
        return "\(host)/\(path)"
    }
}

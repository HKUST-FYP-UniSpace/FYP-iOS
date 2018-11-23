//
//  AlamofireAuthService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

extension AlamofireService: AuthService {
    
    func authorize(completion: @escaping (User?, Error?) -> ()) {
        post(at: .authorize, params: getCredentials()).responseObject {
            (res: DataResponse<UserModel>) in
            completion(res.result.value, res.result.error)
        }
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (User?, Error?) -> ()) {
        let params = convertRegisterInfoToParams(userType: userType, username: username, name: name, email: email, password: password)
        post(at: .register, params: params).responseObject {
            (res: DataResponse<UserModel>) in
            completion(res.result.value, res.result.error)
        }
    }
    
    func verify(userId: Int, code: String, completion: @escaping (User?, Error?) -> ()) {
        var params = Parameters()
        params["code"] = code
        post(at: .verify(userId: userId), params: params).responseObject {
            (res: DataResponse<UserModel>) in
            completion(res.result.value, res.result.error)
        }
    }
    
    fileprivate func getCredentials() -> Dictionary<String,String> {
        return [
            "username": UserDefaultsManager.getPref("username") ?? "",
            "password": UserDefaultsManager.getPref("password") ?? ""
        ]
    }
    
    fileprivate func convertRegisterInfoToParams(userType: UserType, username: String, name: String, email: String, password: String) -> Parameters {
        var params = Parameters()
        params["userType"] = userType
        params["username"] = username
        params["name"] = name
        params["email"] = email
        params["password"] = password
        return params
    }
    
}

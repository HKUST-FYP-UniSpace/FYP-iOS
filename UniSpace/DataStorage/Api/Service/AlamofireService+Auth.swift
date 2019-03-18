//
//  AlamofireAuthService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: AuthService {
    
    func authorize(completion: @escaping (UserModel?, Error?) -> Void) {
        post(at: .authorize, params: getCredentials()).responseJSON { (res: DataResponse<Any>) in
            var result: UserModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(UserModel.self, from: data) }
//            result = TestUserModel(email: "register@gmail.com",
//                                   username: "register",
//                                   role: .Tenant,
//                                   verified: true,
//                                   hasPreference: false).toUserModel()
            DataStore.shared.user = result
            completion(result, res.result.error)
        }
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (UserModel?, Error?) -> Void) {
        let params = convertRegisterInfoToParams(userType: userType, username: username, name: name, email: email, password: password)
        post(at: .register, params: params).responseJSON { (res: DataResponse<Any>) in
            var result: UserModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(UserModel.self, from: data) }
            completion(result, res.result.error)
        }
    }
    
    func verify(userId: Int, code: String, completion: @escaping (UserModel?, Error?) -> Void) {
        var params = Parameters()
        params["code"] = code
        post(at: .verify(userId: userId), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: UserModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(UserModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func existUsername(username: String, completion: @escaping (Bool?, Error?) -> Void) {
        post(at: .existUsername(username: username)).responseJSON { (res: DataResponse<Any>) in
            var result: Bool? = nil
            if let data = res.data { result = try? JSONDecoder().decode(Bool.self, from: data) }
            completion(result, res.result.error)
        }
    }
    
    fileprivate func getCredentials() -> Dictionary<String,String> {
        return [
            "username": DataStore.shared.getPref(.username) ?? "",
            "password": DataStore.shared.getPref(.password) ?? ""
        ]
    }
    
    fileprivate func convertRegisterInfoToParams(userType: UserType, username: String, name: String, email: String, password: String) -> Parameters {
        var params = Parameters()
        params["userType"] = userType.rawValue
        params["username"] = username
        params["name"] = name
        params["email"] = email
        params["password"] = password
        return params
    }
    
}

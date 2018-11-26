//
//  AlamofireGeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: GeneralService {
    
    func getUserProfile(userId: Int, completion: @escaping (UserProfileModel?, Error?) -> ()) {
        get(at: .getUserProfile(userId: userId)).responseJSON { (res: DataResponse<Any>) in
            var result: UserProfileModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(UserProfileModel.self, from: data) }
            completion(result, res.result.error)
        }
    }
    
}

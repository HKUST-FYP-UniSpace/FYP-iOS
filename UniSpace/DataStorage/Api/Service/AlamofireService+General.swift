//
//  AlamofireGeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

extension AlamofireService: GeneralService {
    
    func getUserProfile(userId: Int, completion: @escaping (UserProfile?, Error?) -> ()) {
        get(at: .getUserProfile(userId: userId)).responseObject {
            (res: DataResponse<UserProfileModel>) in
            completion(res.result.value, res.result.error)
        }
    }
    
}

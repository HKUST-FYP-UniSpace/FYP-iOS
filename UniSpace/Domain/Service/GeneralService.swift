//
//  GeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

protocol GeneralService: class {
    
    func getUserProfile(userId: Int, completion: @escaping (_ user: UserProfile?, _ error: Error?) -> ())
}

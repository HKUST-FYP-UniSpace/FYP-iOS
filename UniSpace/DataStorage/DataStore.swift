//
//  DataStore.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

class DataStore: NSObject {
    
    public static let shared: DataStore = DataStore()
    
    private override init() {
        super.init()
    }
    
    func Service() -> AuthService & GeneralService {
        return true ? TestService.shared : AlamofireService.shared
    }
    
    var userInfo: User?
    
}

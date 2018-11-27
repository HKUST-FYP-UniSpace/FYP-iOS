//
//  DataStore-local.swift
//  UniSpace
//
//  Created by KiKan Ng on 27/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension DataStore {
    
    func savePref(_ key: String, value: String) {
        KeychainManager.shared.savePref(key, value: value)
    }
    
    func getPref(_ key: String) -> String? {
        return KeychainManager.shared.getPref(key)
    }
    
    func removePref(_ key: String) {
        KeychainManager.shared.removePref(key)
    }
    
    func saveObject(_ key: String, value: Any) {
        UserDefaultsManager.savePrefObject(key, value: value)
    }
    
    func getObject(_ key: String) -> Any? {
        return UserDefaultsManager.getPrefObject(key)
    }
    
}

//
//  KeychainManager.swift
//  UniSpace
//
//  Created by KiKan Ng on 27/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import KeychainAccess

class KeychainManager {
    
    public static let shared: KeychainManager = KeychainManager()
    
    private let keychain = Keychain(service: "com.hkust.unispace-token")
    
    func savePref(_ key: String, value: String) {
        keychain[key] = value
    }
    
    func getPref(_ key: String) -> String? {
        return keychain[key]
    }
    
    func removePref(_ key: String) {
        keychain[key] = nil
        try? keychain.remove(key)
    }
    
}

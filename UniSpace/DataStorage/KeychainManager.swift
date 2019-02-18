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

    private let keychain = Keychain(service: "com.fyp.unispace-token")

    func savePref(_ key: KeychainKeys, value: String) {
        keychain[key.rawValue] = value
    }

    func getPref(_ key: KeychainKeys) -> String? {
        return keychain[key.rawValue]
    }

    func removePref(_ key: KeychainKeys) {
        keychain[key.rawValue] = nil
        do {
            try keychain.remove(key.rawValue)
        } catch {
            log.warning("Keychain", context: "Could not remove key: \(key.rawValue)")
        }
    }

}

//
//  DataStore-local.swift
//  UniSpace
//
//  Created by KiKan Ng on 27/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension DataStore {

    func savePref(_ key: KeychainKeys, value: String) {
        KeychainManager.shared.savePref(key, value: value)
    }

    func getPref(_ key: KeychainKeys) -> String? {
        return KeychainManager.shared.getPref(key)
    }

    func removePref(_ key: KeychainKeys) {
        KeychainManager.shared.removePref(key)
    }

    func unsafeSavePref(_ key: UserDefaultKeys, value: String) {
        UserDefaultsManager.savePref(key, value: value)
    }

    func unsafeGetPref(_ key: UserDefaultKeys) -> String? {
        return UserDefaultsManager.getPref(key)
    }

    func unsafeRemovePref(_ key: UserDefaultKeys) {
        UserDefaultsManager.removePref(key)
    }

    func saveObject(_ key: String, value: Any) {
        UserDefaultsManager.savePrefObject(key, value: value)
    }

    func getObject(_ key: String) -> Any? {
        return UserDefaultsManager.getPrefObject(key)
    }

}

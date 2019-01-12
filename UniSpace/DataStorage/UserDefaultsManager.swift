//
//  UserDefaultsManager.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class UserDefaultsManager {

    static func savePref(_ key: UserDefaultKeys, value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }

    static func getPref(_ key: UserDefaultKeys)-> String? {
        let defaults = UserDefaults.standard
        if let value = defaults.string(forKey: key.rawValue) {
            return value
        }
        return nil
    }

    static func savePrefObject(_ key: String, value: Any) {
        let defaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: value)
        defaults.set(encodedData, forKey: key)
    }

    static func getPrefObject(_ key: String) -> Any? {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: key){
            return NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
        }
        return nil
    }

    static func removePref(_ key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }

}

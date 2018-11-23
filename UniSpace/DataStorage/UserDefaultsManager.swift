//
//  UserDefaultsManager.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class UserDefaultsManager {
    
    static func getString(_ key: String) -> String {
        let lang = UserDefaultsManager.getPref("app-lang") ?? "en"
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let string = bundle?.localizedString(forKey: key, value: nil, table: nil)
        if let string = string {
            return string
        }
        return ""
    }
    
    static func savePref(_ key: String, value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func getPref(_ key: String) -> String? {
        let defaults = UserDefaults.standard
        if let value = defaults.string(forKey: key){
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
    
    static func removePref(_ key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
    
}

//
//  AppDelegateExten.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

let log = Logger(canLocalLog: true, canServerLog: false)

extension AppDelegate {
    
    func redirecting(authorized: Bool) {
        let rootController: UIViewController = authorized ?
            MainTabBarController() :
            UINavigationController(rootViewController: LoginVC())
        
        window?.rootViewController?.loadViewIfNeeded()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
    
    func addUserCredential() {
        DataStore.shared.savePref(.username, value: "abcdef")
        DataStore.shared.savePref(.password, value: "12345678")
    }
    
    func tryToLogin() {
        DataStore.shared.authorize { (user, error) in
            self.redirecting(authorized: user != nil)
        }
    }
    
}

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

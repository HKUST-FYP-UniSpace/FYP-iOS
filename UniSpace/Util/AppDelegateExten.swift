//
//  AppDelegateExten.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit
import SwiftyBeaver

let log = SwiftyBeaver.self

extension AppDelegate {
    
    func redirecting(authorized: Bool) {
        let rootController: UIViewController = authorized ?
            MainTabBarController() :
            UINavigationController(rootViewController: LoginVC())
        
        window?.rootViewController?.loadViewIfNeeded()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
    
    func enableLogging() {
        let console = ConsoleDestination()
        let format = "$DHH:mm:ss$d $C$L$c | $M | $X"
        console.format = format
        log.addDestination(console)
    }
    
    func addUserCredential() {
        DataStore.shared.savePref("username", value: "abcdef")
        DataStore.shared.savePref("password", value: "12345678")
//        log.debug("Home Dir", context: NSHomeDirectory())
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

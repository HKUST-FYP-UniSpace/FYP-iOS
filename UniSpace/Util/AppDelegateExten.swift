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
    
    func redirecting(_ user: User?) {
        guard let user = user else {
            let rootController: UIViewController = UINavigationController(rootViewController: LoginVC())
            window?.rootViewController?.loadViewIfNeeded()
            window?.rootViewController = rootController
            window?.makeKeyAndVisible()
            return
        }

        let rootController: UIViewController = MainTabBarController(user.userType)
        window?.rootViewController?.loadViewIfNeeded()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()

        guard user.verified else {
            self.window?.rootViewController?.present(VerificationVC(), animated: true, completion: nil)
            return
        }

        guard user.preference.allSet() || user.userType == .Owner else {
            self.window?.rootViewController?.present(UINavigationController(rootViewController: PreferenceVC()), animated: true, completion: nil)
            return
        }
    }
    
    func addUserCredential() {
        DataStore.shared.savePref(.username, value: "register")
        DataStore.shared.savePref(.password, value: "12345678aa")
    }
    
    func tryToLogin() {
        DataStore.shared.authorize { (user, error) in
            self.redirecting(user)
        }
    }
    
}

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

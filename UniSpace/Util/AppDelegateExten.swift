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

        let rootController: UIViewController = MainTabBarController(user.role)
        window?.rootViewController?.loadViewIfNeeded()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()

        guard !user.preference.allSet() else { return }
        self.window?.rootViewController?.present(UINavigationController(rootViewController: PreferenceVC()), animated: true, completion: nil)
    }
    
    func addUserCredential() {
        DataStore.shared.savePref(.username, value: "abcdef")
        DataStore.shared.savePref(.password, value: "12345678")
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

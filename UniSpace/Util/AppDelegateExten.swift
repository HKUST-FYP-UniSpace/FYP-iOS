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

        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        guard user.verified else {
            generator.notificationOccurred(.success)
            self.window?.rootViewController?.present(VerificationVC(), animated: true, completion: nil)
            return
        }

        guard user.preference.allSet() || user.userType == .Owner else {
            generator.notificationOccurred(.success)
            self.window?.rootViewController?.present(UINavigationController(rootViewController: PreferenceVC()), animated: true, completion: nil)
            return
        }
    }
    
    func addUserCredential() {
        // Alamofire Service
        DataStore.shared.savePref(.username, value: "server")
        DataStore.shared.savePref(.password, value: "12345678aa")

        // Test Service
        let user = TestUserModel(email: "123@test.com",
                                 username: "StarSpangledMan",
                                 name: "Steve Rogers",
                                 role: .Tenant,
                                 verified: true,
                                 hasPreference: true)
        user.photoURL = "https://cdn1us.denofgeek.com/sites/denofgeekus/files/styles/main_wide/public/2016/08/steve-rogers.jpg?itok=PKuv3pPL"
        DataStore.shared.user = user.toUserModel()
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

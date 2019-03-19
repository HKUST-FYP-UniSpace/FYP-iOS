//
//  AppDelegate.swift
//  UniSpace
//
//  Created by KiKan Ng on 17/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        addUserCredential()
        Connectivity.shared.startNetworkReachabilityObserver()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = Color.theme
        window?.backgroundColor = .white

        // Test user
        let user = TestUserModel(email: "123@test.com",
                                 username: "StarSpangledMan",
                                 name: "Steve Rogers",
                                 role: .Tenant,
                                 verified: true,
                                 hasPreference: true)
        user.photoURL = "https://cdn1us.denofgeek.com/sites/denofgeekus/files/styles/main_wide/public/2016/08/steve-rogers.jpg?itok=PKuv3pPL"
        DataStore.shared.user = user.toUserModel()
        tryToLogin()
        return true
    }


}


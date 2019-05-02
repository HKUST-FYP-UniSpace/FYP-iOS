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
        DataStore.shared.changeService(.Alamofire)
//        addUserCredential(.Alamofire, role: .Tenant)
        Connectivity.shared.startNetworkReachabilityObserver()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = Color.theme
        window?.backgroundColor = .white

        tryToLogin()
        return true
    }


}


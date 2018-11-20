//
//  MainTabBarController.swift
//  UniSpace
//
//  Created by KiKan Ng on 18/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let apartmentVC = ApartmentVC()
        apartmentVC.tabBarItem = UITabBarItem(title: "Apartment", image: UIImage(named: "Apartment"), tag: 0)
        
        let tradeVC = TradeVC()
        tradeVC.tabBarItem = UITabBarItem(title: "Trade", image: UIImage(named: "Trade"), tag: 1)
        
        let blogVC = BlogVC()
        blogVC.tabBarItem = UITabBarItem(title: "Blog", image: UIImage(named: "Blog"), tag: 2)
        
        let messageVC = MessageVC()
        messageVC.tabBarItem = UITabBarItem(title: "Message", image: UIImage(named: "Message"), tag: 3)
        
        let settingsVC = SettingsVC()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "Settings"), tag: 4)
        
        let tabBarList = [apartmentVC, tradeVC, blogVC, messageVC, settingsVC]
        viewControllers = tabBarList.map {
            UINavigationController(rootViewController: $0)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

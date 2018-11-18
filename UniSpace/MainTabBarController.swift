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

        let firstViewController = FirstViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let tabBarList = [firstViewController, secondViewController]
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

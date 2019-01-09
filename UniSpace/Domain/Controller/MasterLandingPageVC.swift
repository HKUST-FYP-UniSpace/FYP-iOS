//
//  MasterLandingPageVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/12/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class MasterLandingPageVC: MasterVC {

    lazy var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "what are you looking for"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
}

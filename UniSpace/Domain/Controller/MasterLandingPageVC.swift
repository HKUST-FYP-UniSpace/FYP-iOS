//
//  MasterLandingPageVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/12/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class MasterLandingPageVC: MasterVC, UISearchBarDelegate {

    lazy var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "what are you looking for"
        searchBar.backgroundColor = .clear
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        searchBar.text = nil
        searchBarCancelButtonClicked(searchBar)
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let cancelSearchBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBarButtonItemClicked))
        self.navigationItem.setRightBarButton(cancelSearchBarButtonItem, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.navigationItem.setRightBarButton(nil, animated: true)
    }

    @objc func cancelBarButtonItemClicked() {
        self.searchBarCancelButtonClicked(self.searchBar)
    }
}

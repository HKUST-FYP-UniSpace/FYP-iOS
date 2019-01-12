//
//  MasterLoginVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class MasterLoginVC: MasterVC {
    
    let sideMaxBound: CGFloat = 20
    let sideSuggestBound: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setupTheme(theme: UIColor, background: UIColor) {
        super.setupTheme(theme: theme, background: background)
        setupBackButtom(color: theme)
    }
    
}

extension MasterLoginVC {
    
    private func setupBackButtom(color: UIColor) {
        let backItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(back))
        backItem.tintColor = color
        backItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        backItem.customView?.widthAnchor.constraint(equalToConstant: 10).isActive = true
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}

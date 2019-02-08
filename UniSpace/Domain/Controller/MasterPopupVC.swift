//
//  MasterPopupVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/12/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class MasterPopupVC: MasterVC {

    override func viewDidLoad() {
        setupTheme(theme: Color.theme, background: .clear)
        let cancelItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(cancelButton))

        cancelItem.tintColor = UIColor.darkGray
        navigationItem.leftBarButtonItem = cancelItem
    }

    @objc func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

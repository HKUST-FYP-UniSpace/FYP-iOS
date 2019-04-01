//
//  MasterFilterVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 13/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class MasterFilterVC: MasterFormPopupVC {

    private var isSimpleFilter: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "What are you looking for?"
        // TODO: Advance filter
//        navigationItem.rightBarButtonItem = setupSwtichModeButton()
        setupSimpleFilter()
    }

    private func setupSwtichModeButton() -> UIBarButtonItem {
        let buttonTitle = !isSimpleFilter ? "Simple" : "Advance"
        let advanceItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(advanceButton))
        advanceItem.tintColor = Color.theme
        return advanceItem
    }

    @objc func advanceButton(_ sender: UIButton) {
        form.removeAll()
        if isSimpleFilter { setupAdvanceFilter() }
        else { setupSimpleFilter() }
        tableView.reloadData()

        isSimpleFilter = !isSimpleFilter
        navigationItem.rightBarButtonItem = setupSwtichModeButton()
    }

    func setupSimpleFilter() {}

    func setupAdvanceFilter() {}

}

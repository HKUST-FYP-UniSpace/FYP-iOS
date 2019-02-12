//
//  TradeFilterVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class TradeFilterVC: FormViewController {

    var filter: TradeFilterModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        title = "What are you looking for?"
        let cancelItem = UIBarButtonItem(image: UIImage(named: "Delete"), style: .plain, target: self, action: #selector(cancelButton))
        let advanceItem = UIBarButtonItem(title: "Advance", style: .done, target: self, action: #selector(advanceButton))

        cancelItem.tintColor = .darkGray
        advanceItem.tintColor = Color.theme
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = advanceItem

        self.setupTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupTheme(theme: Color.theme, background: Color.white, withLine: false)
        navigationItem.largeTitleDisplayMode = .never
        tableView.tableFooterView = UIView()
    }

    @objc func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc func advanceButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    private func setupTable() {
        form +++ Section("Search")
            <<< MultipleSelectorRow<String>() {
                $0.title = "Search by"
                $0.options = ["Title", "Seller"]
                }

            <<< MultipleSelectorRow<String>() {
                $0.title = "Category"
                $0.options = ["Kitchenwares", "Electronics and Gadgets", "Furnitures"]
                }

            <<< MultipleSelectorRow<String>() {
                $0.title = "Item condition"
                $0.options = ["Perfect", "Almost perfect", "Okay"]
                }

        form +++ Section("Price (HK$)")
            <<< SliderRow() {
                $0.title = "Max"
                $0.value = 1000
                $0.displayValueFor = { return "\(Int($0 ?? 0).addComma()!)" }
                }
                .cellSetup { cell, row in
                    cell.slider.minimumValue = 300
                    cell.slider.maximumValue = 1000
                    cell.slider.widthAnchor.constraint(equalToConstant: Constants.screenWidth - 240).isActive = true
                    cell.valueLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
            }

            <<< SliderRow() {
                $0.title = "Min"
                $0.value = 0
                $0.displayValueFor = { return "\(Int($0 ?? 0).addComma()!)" }
                }
                .cellSetup { cell, row in
                    cell.slider.minimumValue = 0
                    cell.slider.maximumValue = 500
                    cell.slider.widthAnchor.constraint(equalToConstant: Constants.screenWidth - 240).isActive = true
                    cell.valueLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }

        form +++ Section("")
            <<< ActionSheetRow<String>() {
                $0.title = "Sort by"
                $0.selectorTitle = "Sort by"
                $0.options = ["Recent", "Top", "Hot"]
                $0.value = "-"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
        }

        form +++ Section("")
            <<< ButtonRow() {
                $0.title = "Search"
                }
                .cellSetup { (cell, row) in
                    cell.backgroundColor = Color.theme
                    cell.tintColor = .white
                }
                .onCellSelection { (cell, row) in
                    self.dismiss(animated: true, completion: nil)
        }
    }

}

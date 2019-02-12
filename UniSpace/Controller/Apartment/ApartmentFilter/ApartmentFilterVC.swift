//
//  ApartmentFilterVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class ApartmentFilterVC: FormViewController {

    var filter: HouseFilterModel?

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
    }

    override func viewWillAppear(_ animated: Bool) {
        setupTheme(theme: Color.theme, background: Color.white, withLine: false)
        navigationItem.largeTitleDisplayMode = .never

        form.removeAll()
        self.setupTable()
        self.tableView.reloadData()
        tableView.tableFooterView = UIView()
    }

    @objc func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc func advanceButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    private func setupTable() {
        form +++ Section("")
            <<< ActionSheetRow<String>() {
                $0.title = "University"
                $0.selectorTitle = "Pick your university"
                $0.options = ["Hong Kong University", "Chinese University", "HKUST", "Poly University"]
                $0.value = "-"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
        }

        form +++ Section("Price (HK$)")
            <<< SliderRow() {
                $0.title = "Max"
                $0.value = 30000
                $0.displayValueFor = { return "\(Int($0 ?? 0).addComma()!)" }
                }
                .cellSetup { cell, row in
                    cell.slider.minimumValue = 10000
                    cell.slider.maximumValue = 30000
                    cell.slider.widthAnchor.constraint(equalToConstant: Constants.screenWidth - 240).isActive = true
                    cell.valueLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
            }

            <<< SliderRow() {
                $0.title = "Min"
                $0.value = 5000
                $0.displayValueFor = { return "\(Int($0 ?? 0).addComma()!)" }
                }
                .cellSetup { cell, row in
                    cell.slider.minimumValue = 5000
                    cell.slider.maximumValue = 20000
                    cell.slider.widthAnchor.constraint(equalToConstant: Constants.screenWidth - 240).isActive = true
                    cell.valueLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }

        form +++ Section("Size (sq. ft.)")
            <<< SliderRow() {
                $0.title = "Max"
                $0.value = 2000
                $0.displayValueFor = { return "\(Int($0 ?? 0).addComma()!)" }
                }
                .cellSetup { cell, row in
                    cell.slider.minimumValue = 800
                    cell.slider.maximumValue = 2000
                    cell.slider.widthAnchor.constraint(equalToConstant: Constants.screenWidth - 240).isActive = true
                    cell.valueLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
            }

            <<< SliderRow() {
                $0.title = "Min"
                $0.value = 500
                $0.displayValueFor = { return "\(Int($0 ?? 0).addComma()!)" }
                }
                .cellSetup { cell, row in
                    cell.slider.minimumValue = 500
                    cell.slider.maximumValue = 1000
                    cell.slider.widthAnchor.constraint(equalToConstant: Constants.screenWidth - 240).isActive = true
                    cell.valueLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }

        form +++ Section("")
            <<< StepperRow() {
                $0.title = "Travelling Time (mins.)"
                $0.value = 10
                $0.displayValueFor = { return "< \(Int($0 ?? 0).addComma()!)" }
                }
                .cellSetup { (cell, row) in
                    cell.stepper.minimumValue = 10
                    cell.stepper.maximumValue = 90
                    cell.stepper.stepValue = 10
            }

            <<< SwitchRow() {
                $0.title = "Team Formed"
                }
                .cellSetup { (cell, row) in
                    cell.switchControl.onTintColor = Color.theme
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

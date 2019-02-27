//
//  SettingsVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class SettingsVC: FormViewController {

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        tableView.backgroundColor = .white
        setupTheme(theme: Color.theme, background: Color.white, withLine: false)
        tableView.tableFooterView = UIView()

        form.removeAll()
        loadData()
    }

    private func loadData() {
        DataStore.shared.getUserProfile { (user, error) in
            self.createForm(user)
            self.tableView.reloadData()
        }
    }

    private func createForm(_ user: UserProfileModel?) {
        form +++ Section("")
            <<< UserInfoRow { row in
                row.cell.nameLabel.text = user?.username
                row.cell.preferenceLabel.text = user?.preference.getTextForm()
                row.cell.setImage(image: nil)

                guard let url = user?.photoURL else { return }
                AlamofireService.shared.downloadImageData(at: url, downloadProgress: nil) { (data, error) in
                    guard let data = data else { return }
                    row.cell.setImage(image: UIImage(data: data))
                }
            }

            <<< LabelRow() {
                $0.title = "Preference Settings"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    self.present(UINavigationController(rootViewController: PreferenceVC()), animated: true, completion: nil)
                }

            <<< LabelRow() {
                $0.title = "Apartment History"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    //
            }

            <<< LabelRow() {
                $0.title = "Trade History"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    //
            }

            <<< LabelRow() {
                $0.title = "Pending Requests"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    //
            }

            <<< SwitchRow() {
                $0.title = "Notification"
                $0.value = true
                }
                .cellSetup { (cell, row) in
                    cell.switchControl.onTintColor = Color.theme
                }
                .onChange { (row) in
                }

            <<< LabelRow() {
                $0.title = "Rules and Regulations"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    //
                }

            <<< LabelRow() {
                $0.title = "Sign Out"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = .red
                }
                .onCellSelection { (cell, row) in
                    //
                }
    }
    
}

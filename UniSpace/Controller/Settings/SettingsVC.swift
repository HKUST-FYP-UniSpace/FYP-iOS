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

    private func createForm(_ user: UserModel?) {
        form +++ Section("")
            <<< UserInfoRow { row in
                row.cell.nameLabel.text = user?.getNameAndUsername()
                row.cell.preferenceLabel.text = user?.preference.getTextForm()

                guard let url = user?.photoURL else { return }
                AlamofireService.shared.downloadImage(at: url, downloadProgress: nil) { (image, error) in
                    row.cell.setImage(image)
                }
                }
                .onCellSelection { (cell, row) in
                    let generator = UINotificationFeedbackGenerator()
                    generator.prepare()
                    let vc = UserDetailVC()
                    vc.userId = DataStore.shared.user?.id
                    generator.notificationOccurred(.success)
                    self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                }

            <<< LabelRow() {
                $0.title = "Preference Settings"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    self.present(UINavigationController(rootViewController: PreferenceVC()), animated: true, completion: nil)
                }

            <<< LabelRow() {
                $0.title = "Apartment History"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    self.navigationController?.pushViewController(ApartmentListVC(.History), animated: true)
            }

            <<< LabelRow() {
                $0.title = "Trade History"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    self.navigationController?.pushViewController(TradeListVC(.History), animated: true)
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
                    super.logout()
                }
    }
    
}

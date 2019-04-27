//
//  MessageInfoVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class MessageInfoVC: MasterFormPopupVC {

    var info: MessageSummaryModel?
    private var teamView: TeamSummaryViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Information"
        loadData()
    }

    private func loadData() {
        guard let info = info, info.messageType == .Team else {
            createForm()
            return
        }
        DataStore.shared.getTeamView(teamId: info.teamId) { (model, error) in
            self.teamView = model
            self.createForm()
            self.tableView.reloadData()
        }
    }

    private func createForm() {
        guard let info = info else { return }

        if info.messageType == .Team {
            form +++ Section("")
                <<< getImageRow(url: info.photoURL, canChange: false)
                <<< getLabelRow(id: nil, title: "Team Name", displayValue: info.title)
                <<< getLabelRow(id: nil, title: "Preference", displayValue: teamView?.teamView?.preference.getTextForm())

            if let teamView = teamView, let currentUserId = DataStore.shared.user?.id, let leader = teamView.teamMembers.first(where: { $0.role == .Leader}), currentUserId == leader.id {
                form.last!
                <<< LabelRow() {
                    $0.title = "Preference Settings"
                    }
                    .cellUpdate { (cell, row) in
                        cell.textLabel?.textColor = Color.theme
                    }
                    .onCellSelection { (cell, row) in
                        guard let preference = teamView.teamView?.preference else { return }
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        let vc = PreferenceVC(teamId: info.teamId, preferenceModel: preference)
                        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                    }

                    <<< LabelRow() {
                        $0.title = "Message Owner"
                        }
                        .cellUpdate { (cell, row) in
                            cell.textLabel?.textColor = Color.theme
                        }
                        .onCellSelection { (cell, row) in
                            let generator = UINotificationFeedbackGenerator()
                            generator.prepare()
                            generator.notificationOccurred(.success)
                            let vc = CreateMessageGroupVC(.Owner, teamId: info.teamId)
                            self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                }
            }

            if let teamView = teamView {
                form +++ Section("Team Member")
                for member in teamView.teamMembers {
                    // list out member
                }
            }
        }

        form +++ Section("")
            <<< getLabelRow(id: nil, title: "", displayValue: "")
    }

}

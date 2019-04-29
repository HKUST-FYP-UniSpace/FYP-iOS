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

        switch info.messageType {
        case .Owner: createOwnerForm(info)
        case .Team: createTeamForm(info)
        case .Trade: createTradeForm(info)
        case .Request:
            DataStore.shared.getRequestStatus(messageId: info.id) { (model, error) in
                guard let model = model else { return }
                self.createRequestForm(info, model: model)
            }
        case .Admin: return
        }
    }

    private func createOwnerForm(_ info: MessageSummaryModel) {
        form +++ Section("")
            <<< LabelRow() {
                $0.title = "View House"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    let vc = ApartmentSummaryVC(isBookmarked: true)
                    vc.houseId = info.houseId
                    self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }

        createMemberSection()
    }

    private func createTeamForm(_ info: MessageSummaryModel) {
        form +++ Section("")
            <<< LabelRow() {
                $0.title = "View House"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    let vc = ApartmentSummaryVC(isBookmarked: true)
                    vc.houseId = info.houseId
                    self.navigationController?.pushViewController(vc, animated: true)
        }

        form +++ Section("")
            <<< getImageRow(url: info.photoURL, canChange: false)
            <<< getLabelRow(id: nil, title: "Team Name", displayValue: info.title)
            <<< getTextAreaRow(id: nil, placeholder: "Preference", defaultValue: teamView?.teamView?.preference.getTextForm(), disable: true)


        if let teamView = teamView, let currentUserId = DataStore.shared.user?.id, let leader = teamView.teamMembers.first(where: { $0.role == .Leader}), currentUserId == leader.id {
            createTeamLeaderSection()
        }

        createMemberSection()

        form +++ Section("")
            <<< LabelRow() {
                $0.title = "Leave Group"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = .red
                }
                .onCellSelection { (cell, row) in
                    // TODO
        }
    }

    private func createTradeForm(_ info: MessageSummaryModel) {
        form +++ Section("")
            <<< LabelRow() {
                $0.title = "View Trade Item"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    let vc = TradeDetailVC(isBookmarked: true)
                    vc.tradeItemId = info.tradeId
                    self.navigationController?.pushViewController(vc, animated: true)
        }

        createMemberSection()
    }

    private func createRequestForm(_ info: MessageSummaryModel, model: MessageRequestModel) {
        form +++ Section("")
            <<< LabelRow() {
                $0.title = "View House"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    let vc = ApartmentSummaryVC(isBookmarked: true)
                    vc.houseId = info.houseId
                    self.navigationController?.pushViewController(vc, animated: true)
        }

        createMemberSection()

        if !model.isLeader {
            form +++ Section("")
                <<< getLabelRow(id: nil, title: "Request Status", displayValue: model.status.text)
        } else {
            form +++ Section("")
                <<< ActionSheetRow<String>(nil) {
                    $0.title = "Request Status"
                    $0.options = RequestStatus.allCases.map { $0.text }
                    $0.value = model.status.text
                    }
                    .onPresent { from, to in
                        to.popoverPresentationController?.permittedArrowDirections = .up
                    }
                    .onChange { (row) in
                        guard let newStatus = RequestStatus(text: row.value), model.status != newStatus else { return }
                        self.showAlert(title: "Do you want to change status to \(newStatus.text)?", completion: { (yes) in
                            guard yes else {
                                row.value = model.status.text
                                self.tableView.reloadData()
                                return
                            }
                            DataStore.shared.changeRequestStatus(messageId: info.id, status: newStatus, completion: { (msg, error) in
                                guard !self.sendFailed(msg, error: error) else { return }
                                self.dismiss(animated: true, completion: nil)
                            })
                        })
            }
        }


    }

}

extension MessageInfoVC {

    private func createTeamLeaderSection() {
        form +++ Section("Leader only functions")
            <<< LabelRow() {
                $0.title = "Preference Settings"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    guard let preference = self.teamView?.teamView?.preference else { return }
                    let vc = PreferenceVC(teamId: self.info?.teamId ?? 0, preferenceModel: preference)
                    self.navigationController?.pushViewController(vc, animated: true)
            }

            <<< LabelRow() {
                $0.title = "Message Owner"
                }
                .cellUpdate { (cell, row) in
                    cell.textLabel?.textColor = Color.theme
                }
                .onCellSelection { (cell, row) in
                    let vc = CreateMessageGroupVC(.Owner, teamId: self.info?.teamId)
                    self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func createMemberSection() {
        guard let info = info else { return }

        form +++ Section("Team Member")
        if let teamView = teamView {
            for member in teamView.teamMembers {
                form.last!
                <<< getUserRow(id: nil, title: member.role.text, displayValue: member.name, userId: member.id)
            }
        } else {
            for member in info.users {
                form.last!
                <<< getUserRow(id: nil, title: member.username, displayValue: member.name, userId: member.id)
            }
        }
    }

    func getUserRow(id: String?, title: String?, displayValue: String?, userId: Int?) -> BaseRow {
        return LabelRow(id) {
            $0.title = title
            $0.value = displayValue
            }
            .onCellSelection { (cell, row) in
                let vc = UserDetailVC()
                vc.userId = userId
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

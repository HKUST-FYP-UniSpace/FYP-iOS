//
//  PreferenceVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 19/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

fileprivate enum PreferenceType {
    case userPreference
    case teamPreference
    case creatingTeam
}

class PreferenceVC: MasterFormPopupVC {

    private var type: PreferenceType
    private var teamId: Int?
    private var originalModel: PreferenceModel?
    private var houseId: Int?
    private var image: UIImage?
    private var houseTeamSummaryModel: HouseTeamSummaryModel?
    private var model: PreferenceModel?

    init() {
        self.type = .userPreference
        super.init(nibName: nil, bundle: nil)
    }

    init(teamId: Int, preferenceModel: PreferenceModel) {
        self.teamId = teamId
        self.originalModel = preferenceModel
        self.type = .teamPreference
        super.init(nibName: nil, bundle: nil)
    }

    init(houseId: Int, houseTeamSummaryModel: HouseTeamSummaryModel, image: UIImage) {
        self.houseId = houseId
        self.houseTeamSummaryModel = houseTeamSummaryModel
        self.image = image
        self.type = .creatingTeam
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preference"
        loadData()
    }

    private func loadData() {
        switch type {
        case .creatingTeam:
            loadForm()

        case .userPreference:
            DataStore.shared.getUserProfile { (user, error) in
                self.loadForm(user?.preference)
            }

        case .teamPreference:
            loadForm(originalModel)
        }
    }

    private func loadForm(_ preference: PreferenceModel? = nil) {
        createForm(preference)
        tableView.reloadData()
    }

    private func createForm(_ preference: PreferenceModel?) {
        form +++ Section("Basic information")
            <<< getSingleSelectorRow(id: "gender", title: "Gender", defaultValue: preference?.gender?.text, selectorTitle: nil, options: PreferenceOptions.gender)
            <<< getSwitchRow(id: "petFree", title: "Pet Free", defaultValue: preference?.petFree)
            <<< getSingleSelectorRow(id: "timeInHouse", title: "Time staying in the Apartment", defaultValue: preference?.timeInHouse, selectorTitle: nil, options: PreferenceOptions.timeInHouse)

        form +++ Section(header: "Personal Details", footer: "Pick at least 3 to improve the matching")
            <<< getMultipleSelectorRow(id: "personalities", title: "Personalities", defaultValue: preference?.personalities, selectorTitle: nil, options: PreferenceOptions.personalities)
            <<< getMultipleSelectorRow(id: "interests", title: "Interests", defaultValue: preference?.interests, selectorTitle: nil, options: PreferenceOptions.interests)

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Set", callback: {
                self.updateModel()
                guard let model = self.model, model.allSet() else {
                    self.showAlert(title: "Please finish the form")
                    return
                }

                switch self.type {
                case .creatingTeam: self.createTeam(model)
                case .userPreference: self.changePreference(model)
                case .teamPreference: self.changeTeamPreference(model)
                }
            })
    }

    private func changePreference(_ preferenceModel: PreferenceModel) {
        DataStore.shared.changePreference(preference: preferenceModel, completion: completion)
    }

    private func changeTeamPreference(_ preferenceModel: PreferenceModel) {
        guard let teamId = teamId else { return }
        DataStore.shared.changeTeamPreference(teamId: teamId, preference: preferenceModel, completion: completion)
    }

    private func createTeam(_ preferenceModel: PreferenceModel) {
        guard let houseId = houseId, let houseTeamSummaryModel = houseTeamSummaryModel, let image = image else { return }
        houseTeamSummaryModel.preference = preferenceModel
        DataStore.shared.createTeam(houseId: houseId, model: houseTeamSummaryModel, image: image, completion: completion)
    }

    private func completion(msg: String?, error: Error?) {
        guard !self.sendFailed(msg, error: error) else { return }
        self.dismiss(animated: true, completion: nil)
    }

    private func updateModel() {
        let model = PreferenceModel()
        if let row = form.rowBy(tag: "gender") as? ActionSheetRow<String> {
            if let value = row.value {
                if value == Gender.Male.text {
                    model.gender = .Male
                } else if value == Gender.Female.text {
                    model.gender = .Female
                }
            }
        }
        if let row = form.rowBy(tag: "petFree") as? SwitchRow { model.petFree = row.value }
        if let row = form.rowBy(tag: "timeInHouse") as? ActionSheetRow<String> { model.timeInHouse = row.value }
        if let row = self.form.rowBy(tag: "personalities") as? MultipleSelectorRow<String> {
            if row.value == nil { model.personalities = nil }
            else { model.personalities = Array(row.value!) }
        }
        if let row = self.form.rowBy(tag: "interests") as? MultipleSelectorRow<String> {
            if row.value == nil { model.interests = nil }
            else { model.interests = Array(row.value!) }
        }
        self.model = model
    }

}

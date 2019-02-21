//
//  PreferenceVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 19/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class PreferenceVC: MasterFormPopupVC {

    var model: PreferenceModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preference"
        loadData()
    }

    private func loadData() {
        DataStore.shared.getUserProfile { (user, error) in
            self.createForm(user?.preference)
            self.tableView.reloadData()
        }
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
            <<< getButtonRow(id: nil, title: "Search", callback: {
                self.updateModel()
                guard let model = self.model, model.allSet() else {
                    self.showAlert(title: "Please finish the form")
                    return
                }

                guard let preferenceModel = self.model else { return }
                DataStore.shared.changePreference(preference: preferenceModel, completion: { (msg, errpr) in
                    guard !self.sendFailed(msg, error: errpr) else { return }
                    self.dismiss(animated: true, completion: nil)
                })
            })
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

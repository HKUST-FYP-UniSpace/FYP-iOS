//
//  TeamCreationVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 22/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class TeamCreationVC: MasterFormPopupVC {

    private var houseId: Int
    private var model: HouseTeamSummaryModel?
    private var image: UIImage?

    init(houseId: Int) {
        self.houseId = houseId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Team"
        createForm()
    }

    private func createForm() {
        form +++ Section("Team Information")
            <<< getImageRow(url: nil, canChange: true)
            <<< getTextRow(id: "name", title: "Group Name", defaultValue: nil)
            <<< getTextAreaRow(id: "description", placeholder: "Enter team's description here", defaultValue: nil)
            <<< getStepperRow(id: "size", title: "Group Size", defaultValue: 1, max: 8, min: 1, step: 1, displayWithText: "")
            <<< getStepperRow(id: "duration", title: "Duration (years)", defaultValue: 1, max: 8, min: 1, step: 1, displayWithText: "")

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Next", callback: {
                self.updateModel()
                guard let model = self.model, model.allSet(), let image = self.image else {
                    self.showAlert(title: "Please finish the form")
                    return
                }

                let vc = PreferenceVC(houseId: self.houseId, houseTeamSummaryModel: model, image: image)
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }

    private func updateModel() {
        image = nil
        for row in form.allRows {
            guard let imageRow = row as? ChangeImageRow, let image = imageRow.cell.getImage() else { continue }
            self.image = image
        }

        var name: String? = nil
        var description: String? = nil
        var size: Int? = nil
        var duration: Int? = nil
        if let row = form.rowBy(tag: "name") as? TextRow { name = row.value }
        if let row = form.rowBy(tag: "description") as? TextAreaRow { description = row.value }
        if let row = form.rowBy(tag: "size") as? StepperRow, let value = row.value { size = Int(value) }
        if let row = form.rowBy(tag: "duration") as? StepperRow, let value = row.value { duration = Int(value) }

        guard let updateName = name, !updateName.isEmpty,
            let updateDescription = description, !updateDescription.isEmpty,
            let updateSize = size, let updateDuration = duration else {
                self.model = nil
                return
        }
        let model = HouseTeamSummaryModel()
        model.title = updateName
        model.description = updateDescription
        model.groupSize = updateSize
        model.duration = "\(updateDuration)"
        self.model = model
    }

}

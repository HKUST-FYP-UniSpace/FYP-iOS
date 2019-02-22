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

    private var model: HouseTeamSummaryModel?
    private var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Team"
        createForm()
    }

    private func createForm() {
        form +++ Section("Team Information")

            <<< ChangeImageRow() {
                $0.cell.setImage(image: nil)
                }
                .onCellSelection({ (cell, row) in
                    self.getPhoto(handlePopover: { (actionSheet) in
                        if let popover = actionSheet.popoverPresentationController {
                            popover.sourceView = self.tableView
                            popover.sourceRect = self.tableView.convert(cell.contentView.frame, from: cell)
                        }
                        self.present(actionSheet, animated: true, completion: nil)
                    }, completion: { (image) in
                        cell.setImage(image: image)
                        self.image = image
                    })
                })

            <<< getTextRow(id: "name", title: "Group Name", defaultValue: nil)
            <<< getTextAreaRow(id: "description", placeholder: "Enter your team's description here", defaultValue: nil)
            <<< getStepperRow(id: "size", title: "Group Size", defaultValue: 1, max: 8, min: 1, step: 1, displayWithText: "")

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Next", callback: {
                self.updateModel()
                guard let model = self.model, model.allSet(), let image = self.image else {
                    self.showAlert(title: "Please finish the form")
                    return
                }

                let vc = PreferenceVC(houseTeamSummaryModel: model, image: image)
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }

    private func updateModel() {
        let model = HouseTeamSummaryModel()
        if let row = form.rowBy(tag: "name") as? TextRow, let value = row.value { model.title = value }
        if let row = form.rowBy(tag: "description") as? TextAreaRow, let value = row.value { model.description = value }
        if let row = form.rowBy(tag: "size") as? StepperRow, let value = row.value { model.groupSize = Int(value) }
        self.model = model
    }

}

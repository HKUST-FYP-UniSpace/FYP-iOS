//
//  AddReviewVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class AddReviewVC: MasterFormPopupVC {

    var houseId: Int?
    private var review: HouseReviewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Review"
        createForm()
    }

    private func createForm() {
        let date = DateManager.shared.getCurrentDate()
        form +++ Section("")
            <<< getLabelRow(id: nil, title: "Date", displayValue: DateManager.shared.convertToDateFormat(date: date))
            <<< getStepperRow(id: "value", title: "Value Ratings", defaultValue: 5, max: 5, min: 0, step: 1, displayWithText: "")
            <<< getStepperRow(id: "cleanliness", title: "Cleanliness Ratings", defaultValue: 5, max: 5, min: 0, step: 1, displayWithText: "")
            <<< getStepperRow(id: "accuracy", title: "Accuracy Ratings", defaultValue: 5, max: 5, min: 0, step: 1, displayWithText: "")
            <<< getStepperRow(id: "communication", title: "Communication Ratings", defaultValue: 5, max: 5, min: 0, step: 1, displayWithText: "")
            <<< getTextAreaRow(id: "title", placeholder: "feedback title", defaultValue: nil)
            <<< getTextAreaRow(id: "detail", placeholder: "feedback detail", defaultValue: nil)

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Send", callback: {
                self.updateModel()
                guard let houseId = self.houseId else { return }
                guard let review = self.review else {
                    self.showAlert(title: "Please input all the fields")
                    return
                }
                DataStore.shared.addReview(houseId: houseId, review: review, completion: { (msg, error) in
                    guard !self.sendFailed(msg, error: error) else { return }
                    self.dismiss(animated: true, completion: nil)
                })
            })
    }

    private func updateModel() {
        var value: Double? = nil
        var cleanliness: Double? = nil
        var accuracy: Double? = nil
        var communication: Double? = nil
        var title: String? = nil
        var detail: String? = nil
        if let row = form.rowBy(tag: "value") as? StepperRow, let rowValue = row.value { value = rowValue }
        if let row = form.rowBy(tag: "cleanliness") as? StepperRow, let rowValue = row.value { cleanliness = rowValue }
        if let row = form.rowBy(tag: "accuracy") as? StepperRow, let rowValue = row.value { accuracy = rowValue }
        if let row = form.rowBy(tag: "communication") as? StepperRow, let rowValue = row.value { communication = rowValue }
        if let row = form.rowBy(tag: "title") as? TextAreaRow { title = row.value }
        if let row = form.rowBy(tag: "detail") as? TextAreaRow { detail = row.value }

        guard let updateTitle = title, !updateTitle.isEmpty,
            let updateDetail = detail, !updateDetail.isEmpty,
            let updateV = value, let updateC = cleanliness, let updateA = accuracy, let updateCom = communication else {
                self.review = nil
                return
        }
        let model = HouseReviewModel()
        model.title = updateTitle
        model.detail = updateDetail
        model.value = updateV
        model.cleanliness = updateC
        model.accuracy = updateA
        model.communication = updateCom
        model.date = DateManager.shared.getCurrentDate().timeIntervalSince1970
        self.review = model
    }

}

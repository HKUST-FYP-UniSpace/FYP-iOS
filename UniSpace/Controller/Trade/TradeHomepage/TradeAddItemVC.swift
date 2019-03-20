//
//  TradeAddItemVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 27/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class TradeAddItemVC: MasterFormPopupVC {

    private let unit = "$"
    private var model: TradeFeaturedModel?
    private var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Item"
        createForm()
    }

    private func createForm() {
        form +++ Section("Images")
            <<< getImageRow(url: nil, canChange: true)
            // option 1: append downwards
            <<< getAddImageRow(title: "Add Image")

        // option 2: append a whole section downwards
//        form +++ Section("Images")
//            <<< getAddImageSectionRow(title: "Add Image", sectionTitle: "Images")

        form +++ Section("Item Information")
            <<< getTextRow(id: "name", title: "Name", defaultValue: nil)
            <<< getTextAreaRow(id: "description", placeholder: "Enter item's description here", defaultValue: nil)
            <<< getTextRow(id: "location", title: "Location", defaultValue: nil)
            <<< getPriceRow(id: "price", title: "Price", defaultValue: nil, unit: unit)

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Done", callback: {
                self.updateModel()
                guard let model = self.model, model.allSet(), !self.images.isEmpty else {
                    self.showAlert(title: "Please finish the form")
                    return
                }

                DataStore.shared.createTradeItem(model: model, images: self.images, completion: { (msg, error) in
                    guard !self.sendFailed(msg, error: error) else { return }
                    self.dismiss(animated: true, completion: nil)
                })
            })
    }

    private func updateModel() {
        images.removeAll()
        for row in form.allRows {
            guard let imageRow = row as? ChangeImageRow, let image = imageRow.cell.getImage() else { continue }
            images.append(image)
        }

        var name: String? = nil
        var description: String? = nil
        var location: String? = nil
        var price: Int? = nil
        if let row = form.rowBy(tag: "name") as? TextRow { name = row.value }
        if let row = form.rowBy(tag: "description") as? TextAreaRow { description = row.value }
        if let row = form.rowBy(tag: "location") as? TextRow { location = row.value }
        if let row = form.rowBy(tag: "price") as? TextRow,
            let value = row.value,
            let obtainedPrice = Int(value.deletingPrefix("\(unit) ")) { price = obtainedPrice }

        guard let updateName = name, !updateName.isEmpty,
            let updateDescription = description, !updateDescription.isEmpty,
            let updateLocation = location, !updateLocation.isEmpty,
            let updatePrice = price else {
                self.model = nil
                return
        }
        let model = TradeFeaturedModel()
        model.title = updateName
        model.detail = updateDescription
        model.location = updateLocation
        model.price = updatePrice
        self.model = model
    }
    
}

//
//  OwnerAddHouseVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 14/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class OwnerAddHouseVC: MasterFormPopupVC {

    private let unit = "$"
    private let sizeUnit = "sq. ft."
    private var model: HouseListModel?
    private var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add House"
        createForm()
    }

    private func createForm() {
        form +++ Section("Images")
            <<< getImageRow(url: nil, canChange: true)
            <<< getAddImageRow(title: "Add Image")

        form +++ Section("Information")
            <<< getTextRow(id: "title", title: "Title", defaultValue: nil)
            <<< getTextRow(id: "address", title: "Address", defaultValue: nil)
            <<< getSingleSelectorRow(id: "location", title: "Location", defaultValue: nil, selectorTitle: nil, options: District.allCases.map { $0.rawValue })
            <<< getPriceRow(id: "price", title: "Price", defaultValue: nil, unit: unit, unitIsFront: true)
            <<< getPriceRow(id: "size", title: "Size", defaultValue: nil, unit: sizeUnit, unitIsFront: false)
            <<< getTextAreaRow(id: "subtitle", placeholder: "detail", defaultValue: nil, disable: false)

        form +++ Section("Facilities")
            <<< getTextRow(id: "rooms", title: "Number of Rooms", defaultValue: nil)
            <<< getTextRow(id: "beds", title: "Number of Beds", defaultValue: nil)
            <<< getTextRow(id: "toilets", title: "Number of Toilets", defaultValue: nil)

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Done", callback: {
                self.updateModel()
                guard let model = self.model, model.allSet(), !self.images.isEmpty else {
                    self.showAlert(title: "Please finish the form")
                    return
                }

                DataStore.shared.createHouse(model: model, images: self.images, completion: { (msg, error) in
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

        var title: String? = nil
        var address: String? = nil
        var location: String? = nil
        var price: Int? = nil
        var size: Int? = nil
        var subtitle: String? = nil
        var rooms: Int? = nil
        var beds: Int? = nil
        var toilets: Int? = nil
        if let row = form.rowBy(tag: "title") as? TextRow { title = row.value }
        if let row = form.rowBy(tag: "address") as? TextRow { address = row.value }
        if let row = form.rowBy(tag: "location") as? ActionSheetRow<String> { location = row.value }
        if let row = form.rowBy(tag: "subtitle") as? TextAreaRow { subtitle = row.value }
        if let row = form.rowBy(tag: "price") as? TextRow,
            let value = row.value,
            let obtainedPrice = Int(value.deletingPrefix("\(unit) ")) { price = obtainedPrice }
        if let row = form.rowBy(tag: "size") as? TextRow,
            let value = row.value,
            let obtainedSize = Int(value.deletingSuffix(" \(sizeUnit)")) { size = obtainedSize }
        if let row = form.rowBy(tag: "rooms") as? TextRow, let value = row.value { rooms = Int(value) }
        if let row = form.rowBy(tag: "beds") as? TextRow, let value = row.value { beds = Int(value) }
        if let row = form.rowBy(tag: "toilets") as? TextRow, let value = row.value { toilets = Int(value) }

        guard let updateTitle = title, !updateTitle.isEmpty,
            let updateAddress = address, !updateAddress.isEmpty,
            let updateSubtitle = subtitle, !updateSubtitle.isEmpty,
            let updatePrice = price, let updateSize = size,
            let updateRooms = rooms, let updateBeds = beds,
            let updateToilets = toilets, let updateLocation = location else {
                self.model = nil
                return
        }

        let model = HouseListModel()
        model.title = updateTitle
        model.address = updateAddress
        model.district_id = updateLocation
        model.subtitle = updateSubtitle
        model.price = updatePrice
        model.size = updateSize
        model.rooms = updateRooms
        model.beds = updateBeds
        model.toilets = updateToilets
        self.model = model
    }

}

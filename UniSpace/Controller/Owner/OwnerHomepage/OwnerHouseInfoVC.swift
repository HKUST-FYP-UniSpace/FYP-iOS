//
//  OwnerHouseInfoVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 13/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class OwnerHouseInfoVC: MasterFormPopupVC {

    var houseId: Int?
    var houseCondition: HouseStatus?
    private var house: HouseListModel?
    private var editedHouse: HouseListModel?
    private var images: [UIImage] = []
    private let unit = "$"
    private let sizeUnit = "sq. ft."

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apartment"
        addButton(isEdit: true)
        loadData()
    }

    @objc func editButton(_ sender: UIButton) {
        addButton(isEdit: false)
        form.removeAll()
        editForm()
        tableView.reloadData()
    }

    @objc func doneButton(_ sender: UIButton) {
        updateModel()
        guard let editedHouse = editedHouse, !images.isEmpty else {
            self.showAlert(title: "Please input all cells")
            return
        }

        guard let houseId = houseId else { return }
        editedHouse.id = houseId
        DataStore.shared.editHouse(model: editedHouse, images: images) { (msg, error) in
            guard !self.sendFailed(msg, error: error) else { return }
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func addButton(isEdit: Bool) {
        let title = isEdit ? "Edit" : "Done"
        let style: UIBarButtonItem.Style = isEdit ? .plain : .done
        let action = isEdit ? #selector(editButton) : #selector(doneButton)
        let item = UIBarButtonItem(title: title, style: style, target: self, action: action)
        navigationItem.rightBarButtonItem = item
    }

    private func loadData() {
        guard let houseId = houseId else { return }
        DataStore.shared.getHouseView(houseId: houseId) { (model, error) in
            self.house = model?.titleView
            self.createForm()
            self.tableView.reloadData()
        }
    }

    private func createForm() {
        var price: String? = nil
        var size: String? = nil
        if let house = house,
            let priceWithComma = house.price.addComma(),
            let sizeWithComma = house.size.addComma() {
            price = "\(unit) \(priceWithComma)"
            size = "\(sizeWithComma) sq. ft."
        }
        let rows = getImageRows(urls: house?.photoURLs, canChange: false)

        form +++ Section("")
            <<< ActionSheetRow<String>(nil) {
                $0.title = "House Condition"
                $0.options = HouseStatus.allCases.map { $0.text }
                $0.value = "-"
                if let defaultValue = houseCondition?.text { $0.value = defaultValue }
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
                }
                .onChange { (row) in
                    guard let houseId = self.houseId, let houseCondition = self.houseCondition, let newCondition = HouseStatus(text: row.value), houseCondition != newCondition else { return }
                    log.debug("show alert")
                    self.showAlert(title: "Do you want to change status to \(newCondition.text)?", completion: { (yes) in
                        guard yes else {
                            self.houseCondition = houseCondition
                            row.value = houseCondition.text
                            self.tableView.reloadData()
                            return
                        }
                        DataStore.shared.changeHouseStatus(houseId: houseId, status: newCondition, completion: { (msg, error) in
                            guard !self.sendFailed(msg, error: error) else { return }
                            self.houseCondition = newCondition
                        })
                    })
                }

        form +++ Section("Images")
        for row in rows { form.last! <<< row }

        form +++ Section("Information")
            <<< getLabelRow(id: nil, title: "Title", displayValue: house?.title)
            <<< getLabelRow(id: nil, title: "Address", displayValue: house?.address)
            <<< getLabelRow(id: nil, title: "Price", displayValue: price)
            <<< getLabelRow(id: nil, title: "Size", displayValue: size)
            <<< getTextAreaRow(id: nil, placeholder: "detail", defaultValue: house?.subtitle, disable: true)

        form +++ Section("Facilities")
            <<< getLabelRow(id: nil, title: "Number of Rooms", displayValue: String(house?.rooms))
            <<< getLabelRow(id: nil, title: "Number of Beds", displayValue: String(house?.beds))
            <<< getLabelRow(id: nil, title: "Number of Toilets", displayValue: String(house?.toilets))
    }

    private func editForm() {
        var rows = getImageRows(urls: house?.photoURLs, canChange: true)
        rows.append(getAddImageRow(title: "Add Image"))

        form +++ Section("Images")
        for row in rows { form.last! <<< row }

        form +++ Section("Information")
            <<< getTextRow(id: "title", title: "Title", defaultValue: house?.title)
            <<< getTextRow(id: "address", title: "Address", defaultValue: house?.address)
            <<< getPriceRow(id: "price", title: "Price", defaultValue: String(house?.price), unit: unit, unitIsFront: true)
            <<< getPriceRow(id: "size", title: "Size", defaultValue: String(house?.size), unit: sizeUnit, unitIsFront: false)
            <<< getTextAreaRow(id: "subtitle", placeholder: "detail", defaultValue: house?.subtitle, disable: false)

        form +++ Section("Facilities")
            <<< getTextRow(id: "rooms", title: "Number of Rooms", defaultValue: String(house?.rooms))
            <<< getTextRow(id: "beds", title: "Number of Beds", defaultValue: String(house?.beds))
            <<< getTextRow(id: "toilets", title: "Number of Toilets", defaultValue: String(house?.toilets))
    }

    private func updateModel() {
        images.removeAll()
        for row in form.allRows {
            guard let imageRow = row as? ChangeImageRow, let image = imageRow.cell.getImage() else { continue }
            images.append(image)
        }

        var title: String? = nil
        var address: String? = nil
        var price: Int? = nil
        var size: Int? = nil
        var subtitle: String? = nil
        var rooms: Int? = nil
        var beds: Int? = nil
        var toilets: Int? = nil
        if let row = form.rowBy(tag: "title") as? TextRow { title = row.value }
        if let row = form.rowBy(tag: "address") as? TextRow { address = row.value }
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
            let updateToilets = toilets else {
                self.editedHouse = nil
                return
        }

        let model = HouseListModel()
        model.title = updateTitle
        model.address = updateAddress
        model.subtitle = updateSubtitle
        model.price = updatePrice
        model.size = updateSize
        model.rooms = updateRooms
        model.beds = updateBeds
        model.toilets = updateToilets
        self.editedHouse = model
    }

}

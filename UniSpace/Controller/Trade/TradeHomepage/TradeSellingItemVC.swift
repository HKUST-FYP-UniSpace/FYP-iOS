//
//  TradeSellingItemVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 19/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class TradeSellingItemVC: MasterFormPopupVC {

    var itemId: Int?
    private var sellingItem: TradeFeaturedModel?
    private var editedSellingItem: TradeFeaturedModel?
    private var images: [UIImage] = []
    private let unit = "$"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Selling Item"
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
        guard let editedSellingItem = editedSellingItem, !images.isEmpty else {
            self.showAlert(title: "Please input all cells")
            return
        }

        guard let itemId = itemId else { return }
        editedSellingItem.id = itemId
        DataStore.shared.editTradeItem(model: editedSellingItem, images: images) { (msg, error) in
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
        guard let itemId = itemId else { return }
        DataStore.shared.getTradeDetail(itemId: itemId) { (model, error) in
            self.sellingItem = model
            self.createForm()
            self.tableView.reloadData()
        }
    }

    private func createForm() {
        var price: String? = nil
        if let sellingItem = sellingItem, let priceWithComma = sellingItem.price.addComma() {
            price = "\(unit) \(priceWithComma)"
        }
        let rows = getImageRows(urls: sellingItem?.photoURLs, canChange: false)

        form +++ Section("Images")
        for row in rows { form.last! <<< row }

        form +++ Section("Information")
        <<< getLabelRow(id: nil, title: "Title", displayValue: sellingItem?.title)
        <<< getLabelRow(id: nil, title: "Location", displayValue: sellingItem?.location)
        <<< getLabelRow(id: nil, title: "Price", displayValue: price)
        <<< getTextAreaRow(id: nil, placeholder: "detail", defaultValue: sellingItem?.detail, disable: true)
        <<< getLabelRow(id: nil, title: "Quantity", displayValue: String(sellingItem?.quantity))
        <<< getLabelRow(id: nil, title: "Category", displayValue: sellingItem?.tradeCategory.rawValue)
        <<< getLabelRow(id: nil, title: "Condition", displayValue: sellingItem?.tradeItemCondition.rawValue)

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Stats", callback: {
                let vc = ChartVC()
                vc.id = self.itemId
                vc.isHouse = false
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }

    private func editForm() {
        var price: String? = nil
        if let sellingItem = sellingItem {
            price = "\(sellingItem.price)"
        }
        var rows = getImageRows(urls: sellingItem?.photoURLs, canChange: true)
        rows.append(getAddImageRow(title: "Add Image"))

        form +++ Section("Images")
        for row in rows { form.last! <<< row }

        form +++ Section("Information")
        <<< getTextRow(id: "title", title: "Title", defaultValue: sellingItem?.title)
//        <<< getTextRow(id: "location", title: "Location", defaultValue: sellingItem?.location)
        <<< getSingleSelectorRow(id: "location", title: "Location", defaultValue: sellingItem?.location, selectorTitle: nil, options: District.allCases.map { $0.rawValue })
        <<< getPriceRow(id: "price", title: "Price", defaultValue: price, unit: unit, unitIsFront: true)
        <<< getTextAreaRow(id: "detail", placeholder: "detail", defaultValue: sellingItem?.detail, disable: false)
        <<< getTextRow(id: "quantity", title: "Quantity", defaultValue: String(sellingItem?.quantity))
        <<< getSingleSelectorRow(id: "category", title: "Category", defaultValue: sellingItem?.tradeCategory.rawValue, selectorTitle: nil, options: TradeCategory.allCases.map { $0.rawValue })
        <<< getSingleSelectorRow(id: "condition", title: "Condition", defaultValue: sellingItem?.tradeItemCondition.rawValue, selectorTitle: nil, options: TradeItemCondition.allCases.map { $0.rawValue })
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
        var quantity: Int? = nil
        var category: TradeCategory? = nil
        var itemCondition: TradeItemCondition? = nil
        if let row = form.rowBy(tag: "name") as? TextRow { name = row.value }
        if let row = form.rowBy(tag: "description") as? TextAreaRow { description = row.value }
//        if let row = form.rowBy(tag: "location") as? TextRow { location = row.value }
        if let row = form.rowBy(tag: "location") as? ActionSheetRow<String> { location = row.value }
        if let row = form.rowBy(tag: "price") as? TextRow,
            let value = row.value,
            let obtainedPrice = Int(value.deletingPrefix("\(unit) ")) { price = obtainedPrice }
        if let row = form.rowBy(tag: "quantity") as? TextRow, let value = row.value { quantity = Int(value) }
        if let row = form.rowBy(tag: "category") as? ActionSheetRow<String>,
            let value = row.value, let cat = TradeCategory(rawValue: value) { category = cat }
        if let row = form.rowBy(tag: "condition") as? ActionSheetRow<String>,
            let value = row.value, let condition = TradeItemCondition(rawValue: value) { itemCondition = condition }

        guard let updateName = name, !updateName.isEmpty,
            let updateDescription = description, !updateDescription.isEmpty,
            let updateLocation = location, !updateLocation.isEmpty,
            let updatePrice = price,
            let updateQuantity = quantity,
            let updateCategory = category,
            let updateCondition = itemCondition else {
                self.editedSellingItem = nil
                return
        }
        let model = TradeFeaturedModel()
        model.title = updateName
        model.detail = updateDescription
        model.location = updateLocation
        model.price = updatePrice
        model.quantity = updateQuantity
        model.tradeCategory = updateCategory
        model.tradeItemCondition = updateCondition
        self.editedSellingItem = model
    }

}

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
        <<< getTextRow(id: "location", title: "Location", defaultValue: sellingItem?.location)
        <<< getPriceRow(id: "price", title: "Price", defaultValue: price, unit: unit)
        <<< getTextAreaRow(id: "detail", placeholder: "detail", defaultValue: sellingItem?.detail, disable: false)
    }

    private func updateModel() {
        images.removeAll()
        for row in form.allRows {
            guard let imageRow = row as? ChangeImageRow, let image = imageRow.cell.getImage() else { continue }
            images.append(image)
        }

        let model = TradeFeaturedModel()
        if let row = form.rowBy(tag: "title") as? TextRow { model.title = row.value ?? "" }
        if let row = form.rowBy(tag: "location") as? TextRow { model.location = row.value ?? "" }
        if let row = form.rowBy(tag: "price") as? TextRow,
            let value = row.value,
            let price = Int(value.deletingPrefix("\(unit) ")) { model.price = price }
        if let row = form.rowBy(tag: "detail") as? TextAreaRow { model.detail = row.value ?? "" }
        self.editedSellingItem = model
    }

}

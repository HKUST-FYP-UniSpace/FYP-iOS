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
            <<< createImageRow()
            <<< createAddImageRow()

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
        let model = TradeFeaturedModel()
        for row in form.allRows {
            guard let imageRow = row as? ChangeImageRow, let image = imageRow.cell.getImage() else { continue }
            images.append(image)
        }
        if let row = form.rowBy(tag: "name") as? TextRow, let value = row.value { model.title = value }
        if let row = form.rowBy(tag: "description") as? TextAreaRow, let value = row.value { model.detail = value }
        if let row = form.rowBy(tag: "location") as? TextRow, let value = row.value { model.location = value }
        if let row = form.rowBy(tag: "price") as? TextRow,
            let value = row.value,
            let price = Int(value.deletingPrefix("\(unit) ")) { model.price = price }
        self.model = model
    }

    private func createImageRow() -> BaseRow {
        return ChangeImageRow()
            .onCellSelection({ (cell, row) in
                self.getPhoto(handlePopover: { (actionSheet) in
                    if let popover = actionSheet.popoverPresentationController {
                        popover.sourceView = self.tableView
                        popover.sourceRect = self.tableView.convert(cell.contentView.frame, from: cell)
                    }
                    self.present(actionSheet, animated: true, completion: nil)
                }, completion: { (image) in
                    cell.setImage(image)
                })
            })
    }

    private func createAddImageRow() -> BaseRow {
        return LabelRow() {
            $0.title = "Add Image"
            }.cellSetup({ (cell, row) in
                cell.imageView?.image = UIImage(named: "Inverted_plus")
            })
            .onCellSelection { _, row in
                let cell = self.createImageRow()
                let deleteAction = SwipeAction(style: .destructive, title: "Delete", handler: { (action, row, completionHandler) in
                    row.section?.remove(at: row.indexPath!.row)
                    completionHandler?(true)
                })

                cell.trailingSwipe.actions = [deleteAction]
                cell.trailingSwipe.performsFirstActionWithFullSwipe = true
                row.section?.insert(cell, at: row.indexPath!.row)
                self.tableView.reloadData()
        }
    }

}

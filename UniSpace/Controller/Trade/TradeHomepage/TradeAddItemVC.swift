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
    private var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Item"
        createForm()
    }

    private func createForm() {
        form +++ Section("Item Information")

            <<< ChangeImageRow() {
                $0.cell.setImage(nil)
                }
                .onCellSelection({ (cell, row) in
                    self.getPhoto(handlePopover: { (actionSheet) in
                        if let popover = actionSheet.popoverPresentationController {
                            popover.sourceView = self.tableView
                            popover.sourceRect = self.tableView.convert(cell.contentView.frame, from: cell)
                        }
                        self.present(actionSheet, animated: true, completion: nil)
                    }, completion: { (image) in
                        cell.setImage(image)
                        self.image = image
                    })
                })

            <<< getTextRow(id: "name", title: "Name", defaultValue: nil)
            <<< getTextAreaRow(id: "description", placeholder: "Enter item's description here", defaultValue: nil)
            <<< getTextRow(id: "location", title: "Location", defaultValue: nil)
            <<< getPriceRow(id: "price", title: "Price", defaultValue: nil, unit: unit)

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Done", callback: {
                self.updateModel()
                guard let model = self.model, model.allSet(), let image = self.image else {
                    self.showAlert(title: "Please finish the form")
                    return
                }

                DataStore.shared.createTradeItem(model: model, image: image, completion: { (msg, error) in
                    guard !self.sendFailed(msg, error: error) else { return }
                    self.dismiss(animated: true, completion: nil)
                })
            })
    }

    private func updateModel() {
        let model = TradeFeaturedModel()
        if let row = form.rowBy(tag: "name") as? TextRow, let value = row.value { model.title = value }
        if let row = form.rowBy(tag: "description") as? TextAreaRow, let value = row.value { model.detail = value }
        if let row = form.rowBy(tag: "location") as? TextRow, let value = row.value { model.location = value }
        if let row = form.rowBy(tag: "price") as? TextRow,
            let value = row.value,
            let price = Int(value.deletingPrefix("\(unit) ")) { model.price = price }
        self.model = model
    }

}

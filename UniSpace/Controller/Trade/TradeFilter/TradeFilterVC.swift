//
//  TradeFilterVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

protocol TradeFilterVCDelegate: class {
    func updateFilter(filter: TradeFilterModel?)
}

class TradeFilterVC: MasterFilterVC {

    var filter: TradeFilterModel?
    weak var delegate: TradeFilterVCDelegate?

    override func setupSimpleFilter() {
        form +++ Section("")
            <<< getTextRow(id: "keyword", title: "Keyword", defaultValue: filter?.keyword)

        form +++ Section("Search")
            <<< getMultipleSelectorRow(id: "searchBy", title: "Search by", defaultValue: filter?.searchBy, selectorTitle: "Search by", options: ["Title", "Seller"])
            <<< getMultipleSelectorRow(id: "category", title: "Category", defaultValue: filter?.category, selectorTitle: "Category", options: ["Kitchenwares", "Electronics and Gadgets", "Furnitures"])
            <<< getMultipleSelectorRow(id: "itemCondition", title: "Item condition", defaultValue: filter?.itemCondition, selectorTitle: "Item condition", options: ["Perfect", "Almost perfect", "Okay"])

        form +++ Section("Price (HK$)")
            <<< getSliderRow(id: "priceMax", title: "Max", defaultValue: filter?.maxPrice, max: 1000, min: 300, startFromSmallest: false)
            <<< getSliderRow(id: "priceMin", title: "Min", defaultValue: filter?.minPrice, max: 500, min: 0)

        form +++ Section("")
            <<< getSingleSelectorRow(id: "sortBy", title: "Sort by", defaultValue: filter?.sortBy, selectorTitle: "Sort by", options: ["Recent", "Top", "Hot"])

        form +++ Section("")
            <<< getButtonRow(id: "search", title: "Search", callback: {
                self.updateFilterModel()
                self.delegate?.updateFilter(filter: self.filter)
                self.dismiss(animated: true, completion: nil)
            })
    }

    private func updateFilterModel() {
        let filter = TradeFilterModel()
        if let row = self.form.rowBy(tag: "keyword") as? TextRow { filter.keyword = row.value }
        if let row = self.form.rowBy(tag: "searchBy") as? MultipleSelectorRow<String> { filter.searchBy = Array(row.value ?? []) }
        if let row = self.form.rowBy(tag: "category") as? MultipleSelectorRow<String> { filter.category = Array(row.value ?? []) }
        if let row = self.form.rowBy(tag: "itemCondition") as? MultipleSelectorRow<String> { filter.itemCondition = Array(row.value ?? []) }
        if let row = form.rowBy(tag: "priceMax") as? SliderRow { filter.maxPrice = row.value }
        if let row = form.rowBy(tag: "priceMin") as? SliderRow { filter.minPrice = row.value }
        if let row = form.rowBy(tag: "sortBy") as? ActionSheetRow<String> { filter.sortBy = row.value }
        self.filter = filter
    }

}

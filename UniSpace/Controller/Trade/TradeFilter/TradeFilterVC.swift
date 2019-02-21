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
        let searchByDefault: [String]? = filter?.searchBy == nil ? nil : filter!.searchBy!.map { $0.rawValue }
        let categoryDefault: [String]? = filter?.category == nil ? nil : filter!.category!.map { $0.rawValue }
        let itemConditionDefault: [String]? = filter?.itemCondition == nil ? nil : filter!.itemCondition!.map { $0.rawValue }

        form +++ Section("")
            <<< getTextRow(id: "keyword", title: "Keyword", defaultValue: filter?.keyword)

        form +++ Section("Search")
            <<< getMultipleSelectorRow(id: "searchBy", title: "Search by", defaultValue: searchByDefault, selectorTitle: nil, options: TradeSearchBy.allCases.map { $0.rawValue })
            <<< getMultipleSelectorRow(id: "category", title: "Category", defaultValue: categoryDefault, selectorTitle: nil, options: TradeCategory.allCases.map { $0.rawValue })
            <<< getMultipleSelectorRow(id: "itemCondition", title: "Item condition", defaultValue: itemConditionDefault, selectorTitle: nil, options: TradeItemCondition.allCases.map { $0.rawValue })

        form +++ Section("Price (HK$)")
            <<< getSliderRow(id: "priceMax", title: "Max", defaultValue: filter?.maxPrice, max: 1000, min: 300, startFromSmallest: false)
            <<< getSliderRow(id: "priceMin", title: "Min", defaultValue: filter?.minPrice, max: 500, min: 0)

        form +++ Section("")
            <<< getSingleSelectorRow(id: "sortBy", title: "Sort by", defaultValue: filter?.sortBy?.rawValue, selectorTitle: nil, options: TradeSortBy.allCases.map { $0.rawValue })

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Search", callback: {
                self.updateFilterModel()
                self.delegate?.updateFilter(filter: self.filter)
                self.dismiss(animated: true, completion: nil)
            })
    }

    private func updateFilterModel() {
        let filter = TradeFilterModel()
        if let row = self.form.rowBy(tag: "keyword") as? TextRow { filter.keyword = row.value }
        if let row = self.form.rowBy(tag: "searchBy") as? MultipleSelectorRow<String> {
            if row.value == nil { filter.searchBy = nil }
            else { filter.searchBy = Array(row.value!).compactMap { TradeSearchBy(rawValue: $0) } }
        }
        if let row = self.form.rowBy(tag: "category") as? MultipleSelectorRow<String> {
            if row.value == nil { filter.category = nil }
            else { filter.category = Array(row.value!).compactMap { TradeCategory(rawValue: $0) } }
        }
        if let row = self.form.rowBy(tag: "itemCondition") as? MultipleSelectorRow<String> {
            if row.value == nil { filter.itemCondition = nil }
            else { filter.itemCondition = Array(row.value!).compactMap { TradeItemCondition(rawValue: $0) } }
        }
        if let row = form.rowBy(tag: "priceMax") as? SliderRow { filter.maxPrice = row.value }
        if let row = form.rowBy(tag: "priceMin") as? SliderRow { filter.minPrice = row.value }
        if let row = form.rowBy(tag: "sortBy") as? ActionSheetRow<String> { filter.sortBy = TradeSortBy(rawValue: row.value ?? "") }
        self.filter = filter
    }

}

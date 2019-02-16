//
//  ApartmentFilterVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

protocol ApartmentFilterVCDelegate: class {
    func updateFilter(filter: HouseFilterModel?)
}

class ApartmentFilterVC: MasterFilterVC {

    var filter: HouseFilterModel?
    weak var delegate: ApartmentFilterVCDelegate?

    override func setupSimpleFilter() {
        form +++ Section("")
            <<< getTextRow(id: "keyword", title: "Keyword", defaultValue: filter?.keyword)
            <<< getSingleSelectorRow(id: "university", title: "University", defaultValue: filter?.university?.rawValue, selectorTitle: "Pick your university", options: University.allCases.map { $0.rawValue })

        form +++ Section("Price (HK$)")
            <<< getSliderRow(id: "priceMax", title: "Max", defaultValue: filter?.maxPrice, max: 30000, min: 10000, startFromSmallest: false)
            <<< getSliderRow(id: "priceMin", title: "Min", defaultValue: filter?.minPrice, max: 20000, min: 5000)

        form +++ Section("Size (sq. ft.)")
            <<< getSliderRow(id: "sizeMax", title: "Max", defaultValue: filter?.maxSize, max: 2000, min: 800, startFromSmallest: false)
            <<< getSliderRow(id: "sizeMin", title: "Min", defaultValue: filter?.minSize, max: 1000, min: 500)

        form +++ Section("")
            <<< getStepperRow(id: "travelTime", title: "Travelling Time (mins.)", defaultValue: filter?.maxTravelTime, max: 90, min: 10, step: 10)
            <<< getSwitchRow(id: "teamFormed", title: "Team Formed", defaultValue: filter?.teamFormed)

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Search", callback: {
                self.updateFilterModel()
                self.delegate?.updateFilter(filter: self.filter)
                self.dismiss(animated: true, completion: nil)
            })
    }

    private func updateFilterModel() {
        let filter = HouseFilterModel()
        if let row = form.rowBy(tag: "keyword") as? TextRow { filter.keyword = row.value }
        if let row = form.rowBy(tag: "university") as? ActionSheetRow<String> { filter.university = University(rawValue: row.value ?? "") }
        if let row = form.rowBy(tag: "priceMax") as? SliderRow { filter.maxPrice = row.value }
        if let row = form.rowBy(tag: "priceMin") as? SliderRow { filter.minPrice = row.value }
        if let row = form.rowBy(tag: "sizeMax") as? SliderRow { filter.maxSize = row.value }
        if let row = form.rowBy(tag: "sizeMin") as? SliderRow { filter.minSize = row.value }
        if let row = form.rowBy(tag: "travelTime") as? StepperRow { filter.maxTravelTime = row.value }
        if let row = form.rowBy(tag: "teamFormed") as? SwitchRow { filter.teamFormed = row.value }
        self.filter = filter
    }

}

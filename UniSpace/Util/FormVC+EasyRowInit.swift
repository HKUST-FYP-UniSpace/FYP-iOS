//
//  FormVC+EasyRowInit.swift
//  UniSpace
//
//  Created by KiKan Ng on 19/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

extension FormViewController {
    func getLabelRow(id: String?, title: String?, displayValue: String?) -> BaseRow {
        return LabelRow(id) {
            $0.title = title
            $0.value = displayValue
        }
    }

    func getTextRow(id: String?, title: String?, defaultValue: String?) -> BaseRow {
        return TextRow(id) {
            $0.title = title
            $0.value = defaultValue
            $0.placeholder = "-"
        }
    }

    func getPriceRow(id: String?, title: String?, defaultValue: String?, unit: String) -> BaseRow {
        return TextRow(id) {
            $0.title = title
            $0.value = defaultValue
            $0.placeholder = "-"
            }
            .cellSetup { (cell, row) in
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.numberOfLines = 0
                cell.textField.keyboardType = .numbersAndPunctuation
            }
            .onCellHighlightChanged { (textCell, row) in
                guard var rowValue = row.value else { return }
                textCell.backgroundColor = .clear

                if rowValue.contains(unit) { // is editing cell
                    row.value = ""

                } else { // finish editing cell
                    rowValue = (rowValue == "") ? "-" : (unit + " " + rowValue)
                    row.placeholder = unit

                    let currentRowValue: String = rowValue.deletingPrefix("\(unit) ")
                    if currentRowValue.isNumber() {
                        row.value = unit + " " + currentRowValue
                    } else {
                        textCell.backgroundColor = .yellow
                        return
                    }

                    row.placeholder = row.value
                }
            }
    }

    func getTextAreaRow(id: String?, placeholder: String?, defaultValue: String?) -> BaseRow {
        return TextAreaRow(id) {
            $0.placeholder = placeholder
            $0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
            $0.value = defaultValue
            }
    }

    func getMultipleSelectorRow(id: String?, title: String?, defaultValue: [String]?, selectorTitle: String?, options: [String]?) -> BaseRow {
        return MultipleSelectorRow<String>(id) {
            $0.title = title
            $0.selectorTitle = selectorTitle
            $0.options = options
            if let defaultValue = defaultValue { $0.value = Set(defaultValue) }
        }
    }

    func getSingleSelectorRow(id: String?, title: String?, defaultValue: String?, selectorTitle: String?, options: [String]?) -> BaseRow {
        return ActionSheetRow<String>(id) {
            $0.title = title
            $0.selectorTitle = selectorTitle
            $0.options = options
            $0.value = "-"
            if let defaultValue = defaultValue { $0.value = defaultValue }
            }
            .onPresent { from, to in
                to.popoverPresentationController?.permittedArrowDirections = .up
        }
    }

    func getSliderRow(id: String?, title: String?, defaultValue: Float?, max: Float, min: Float, startFromSmallest: Bool = true) -> BaseRow {
        return SliderRow(id) {
            $0.title = title
            $0.value = startFromSmallest ? min : max
            if let defaultValue = defaultValue { $0.value = defaultValue }
            $0.displayValueFor = { return "\(Int($0 ?? 0).addComma()!)" }
            }
            .cellSetup { cell, row in
                cell.slider.minimumValue = min
                cell.slider.maximumValue = max
                cell.slider.widthAnchor.constraint(equalToConstant: Constants.screenWidth - 240).isActive = true
                cell.valueLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }

    func getStepperRow(id: String?, title: String?, defaultValue: Double?, max: Double, min: Double, step: Double, displayWithText: String = "< ") -> BaseRow {
        return StepperRow(id) {
            $0.title = title
            $0.value = 10
            if let defaultValue = defaultValue { $0.value = defaultValue }
            $0.displayValueFor = { return "\(displayWithText)\(Int($0 ?? 0).addComma()!)" }
            }
            .cellSetup { (cell, row) in
                cell.stepper.minimumValue = min
                cell.stepper.maximumValue = max
                cell.stepper.stepValue = step
        }
    }

    func getSwitchRow(id: String?, title: String?, defaultValue: Bool?) -> BaseRow {
        return SwitchRow(id) {
            $0.title = title
            $0.value = defaultValue
            }
            .cellSetup { (cell, row) in
                cell.switchControl.onTintColor = Color.theme
        }
    }

    func getButtonRow(id: String?, title: String?, callback: @escaping (() -> Void)) -> BaseRow {
        return ButtonRow(id) {
            $0.title = title
            }
            .cellSetup { (cell, row) in
                cell.backgroundColor = Color.theme
                cell.tintColor = .white
            }
            .onCellSelection { (cell, row) in
                callback()
        }
    }
}
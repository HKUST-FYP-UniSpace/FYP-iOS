//
//  MonthSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class MonthSectionController: ListBindingSectionController<ListDiffable>, ListBindingSectionControllerDataSource, ListBindingSectionControllerSelectionDelegate {

    private var selectedDay: Int = -1

    override init() {
        super.init()
        dataSource = self
        selectionDelegate = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        guard let month = object as? Month else { return [] }

        let date = Date()
        let today = Calendar.current.component(.day, from: date)

        var viewModels = [ListDiffable]()

        viewModels.append(MonthTitleViewModel(name: month.name))

        for day in 1..<(month.days + 1) {
            let viewModel = DayViewModel(
                day: day,
                today: day == today,
                selected: day == selectedDay,
                appointments: month.appointments[day]?.count ?? 0
            )
            viewModels.append(viewModel)
        }

        for appointment in month.appointments[selectedDay] ?? [] {
            viewModels.append(appointment)
        }

        return viewModels
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                           cellForViewModel viewModel: Any,
                           at index: Int) -> UICollectionViewCell & ListBindable {
        let cellClass: AnyClass
        if viewModel is DayViewModel {
            cellClass = CalendarDayCell.self
        } else if viewModel is MonthTitleViewModel {
            cellClass = MonthTitleCell.self
        } else {
            cellClass = LabelCell.self
        }
        guard let cell = collectionContext?.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError() }
        return cell
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                           sizeForViewModel viewModel: Any,
                           at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        if viewModel is DayViewModel {
            let square = width / 7.0
            return CGSize(width: square, height: square)
        } else if viewModel is MonthTitleViewModel {
            return CGSize(width: width, height: 30.0)
        } else {
            return CGSize(width: width, height: 55.0)
        }
    }

    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        guard let dayViewModel = viewModel as? DayViewModel else { return }
        if dayViewModel.day == selectedDay {
            selectedDay = -1
        } else {
            selectedDay = dayViewModel.day
        }
        update(animated: true)
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didDeselectItemAt index: Int, viewModel: Any) {}

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didHighlightItemAt index: Int, viewModel: Any) {}

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didUnhighlightItemAt index: Int, viewModel: Any) {}

}

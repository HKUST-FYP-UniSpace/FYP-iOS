//
//  DayViewModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

final class DayViewModel {

    let day: Int
    let today: Bool
    let selected: Bool
    let appointments: Int

    init(day: Int, today: Bool, selected: Bool, appointments: Int) {
        self.day = day
        self.today = today
        self.selected = selected
        self.appointments = appointments
    }

}

extension DayViewModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return day as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? DayViewModel else { return false }
        return today == object.today && selected == object.selected && appointments == object.appointments
    }

}

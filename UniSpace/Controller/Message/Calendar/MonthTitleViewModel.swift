//
//  MonthTitleViewModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

final class MonthTitleViewModel {

    let name: String

    init(name: String) {
        self.name = name
    }

}

extension MonthTitleViewModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard object is MonthTitleViewModel else { return false }
        // name is checked in the diffidentifier, so we can assume its equal
        return true
    }

}

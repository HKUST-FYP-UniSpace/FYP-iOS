//
//  Month.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

final class Month {

    let name: String
    let days: Int

    // day int mapped to an array of appointment names
    let appointments: [Int: [NSString]]

    init(name: String, days: Int, appointments: [Int: [NSString]]) {
        self.name = name
        self.days = days
        self.appointments = appointments
    }

}

extension Month: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
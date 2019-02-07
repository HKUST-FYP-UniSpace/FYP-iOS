//
//  HouseTeamSummary.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseTeamSummary {

    var id: Int { get set }
    var title: String { get set }
    var price: Int { get set }
    var duration: String { get set }
    var subtitle: String { get set }
    var groupSize: Int { get set }
    var occupiedCount: Int { get set }

}

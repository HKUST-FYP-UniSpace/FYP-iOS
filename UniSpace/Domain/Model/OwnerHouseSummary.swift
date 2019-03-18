//
//  OwnerHouseSummary.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol OwnerHouseSummary {

    var id: Int { get set }
    var createTime: Double { get set }
    var title: String { get set }
    var address: String { get set }
    var price: Int { get set }
    var size: Int { get set }
    var numberOfViews: Int { get set }
    var numberOfBookmarks: Int { get set }
    var starRating: Int { get set }
    var arrangingTeamCount: Int { get set }
    var formingTeamCount: Int { get set }
    var houseStatus: HouseStatus { get set }

}

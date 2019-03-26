//
//  OwnerHouseSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class OwnerHouseSummaryModel: Decodable, ListDiffable, OwnerHouseSummary {

    var id: Int = 0
    var createTime: Double = 0
    var title: String = ""
    var address: String = ""
    var price: Int = 0
    var size: Int = 0
    var numberOfViews: Int = 0
    var numberOfBookmarks: Int = 0
    var starRating: Int = 0
    var arrangingTeamCount: Int = 0
    var formingTeamCount: Int = 0
    var houseStatus: HouseStatus = .Reveal

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? OwnerHouseSummaryModel else { return false }
        return self.id == object.id
    }

}
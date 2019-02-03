//
//  TradeHomepageModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class TradeHomepageModel: ListDiffable {

    var id: Int
    var featured: [TradeFeaturedModel] = []
    var sellingItems: [TradeSellingItemModel] = []
    var saved: [TradeFeaturedModel] = []
    var categories: [TradeCategoryModel] = []

    init() {
        id = DataStore.shared.randomInt(length: 8)
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? TradeHomepageModel else { return false }
        return self.id == object.id
    }

}

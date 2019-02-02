//
//  TestTradeCategoryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestTradeCategoryModel: TradeCategory {

    var id: Int
    var title: String
    var pathExtention: String

    required init(title: String, pathExtention: String) {
        id = DataStore.shared.randomInt(length: 8)
        self.title = title
        self.pathExtention = pathExtention
    }

    func toModel() -> TradeCategoryModel {
        let model = TradeCategoryModel()
        model.id = id
        model.title = title
        model.pathExtention = pathExtention
        return model
    }
}

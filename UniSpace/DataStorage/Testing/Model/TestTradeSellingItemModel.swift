//
//  TestTradeSellingItemModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestTradeSellingItemModel: TradeSellingItem {

    var id: Int
    var title: String
    var price: Int
    var views: Int
    var photoURL: String

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = ["Barcelona Chair", "Wassily Chair", "Brno Chair"].randomElement()!
        price = Int.random(in: 20..<100) * 100
        views = Int.random(in: 0..<1000)
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_M, ratio: 0.75)
    }

    func toModel() -> TradeSellingItemModel {
        let model = TradeSellingItemModel()
        model.id = id
        model.title = title
        model.price = price
        model.views = views
        model.photoURL = photoURL
        return model
    }
}

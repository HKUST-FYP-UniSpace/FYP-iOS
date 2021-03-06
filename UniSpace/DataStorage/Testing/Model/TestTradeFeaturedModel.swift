//
//  TestTradeFeaturedModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestTradeFeaturedModel: TradeFeatured {

    var id: Int
    var title: String
    var location: String
    var transactionType: String
    var price: Int
    var status: String
    var detail: String
    var isBookmarked: Bool
    var photoURLs: [String]
    var quantity: Int
    var tradeCategory: TradeCategory
    var tradeItemCondition: TradeItemCondition

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = Lorem.words().capitalized
        location = "Discovery Park, Tsuen Wan"
        transactionType = "out"
        price = Int.random(in: 20..<100) * 100
        status = ["NEW", ""].randomElement()!
        detail = Lorem.sentence()
        isBookmarked = Bool.random()
        photoURLs = []
        for _ in 0...Int.random(in: 2...10) {
            photoURLs.append(Constants.dummyPhotoURL(Constants.cardWidth_M, ratio: 0.75))
        }
        quantity = Int.random(in: 1..<20)
        tradeCategory = TradeCategory.allCases.randomElement()!
        tradeItemCondition = TradeItemCondition.allCases.randomElement()!
    }

    func toModel() -> TradeFeaturedModel {
        let model = TradeFeaturedModel()
        model.id = id
        model.title = title
        model.location = location
        model.transactionType = transactionType
        model.price = price
        model.status = status
        model.detail = detail
        model.isBookmarked = isBookmarked
        model.photoURLs = photoURLs
        return model
    }
}

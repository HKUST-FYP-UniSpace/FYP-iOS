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
    var price: Int
    var status: String
    var detail: String
    var isBookmarked: Bool
    var photoURL: String

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = ["Barcelona Chair", "Wassily Chair", "Brno Chair"].randomElement()!
        location = "Discovery Park, Tsuen Wan"
        price = Int.random(in: 20..<100) * 100
        status = ["NEW", ""].randomElement()!
        detail = Lorem.sentence()
        isBookmarked = Bool.random()
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_M, ratio: 0.75)
    }

    func toModel() -> TradeFeaturedModel {
        let model = TradeFeaturedModel()
        model.id = id
        model.title = title
        model.location = location
        model.price = price
        model.status = status
        model.detail = detail
        model.isBookmarked = isBookmarked
        model.photoURL = photoURL
        return model
    }
}

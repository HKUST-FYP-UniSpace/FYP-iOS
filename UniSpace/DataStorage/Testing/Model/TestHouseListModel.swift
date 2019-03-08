//
//  TestHouseListModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestHouseListModel: HouseList {

    var id: Int
    var title: String
    var price: Int
    var size: Int
    var starRating: Int
    var subtitle: String
    var address: String
    var isBookmarked: Bool
    var photoURL: String

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = "Clear Water Bay Deluxe"
        price = Int.random(in: 50..<200) * 100
        size = Int.random(in: 500..<1500)
        starRating = Int.random(in: 0..<6)
        subtitle = Lorem.sentence()
        address = "8 Clear Water Road, Clear Water Bay, N.T."
        isBookmarked = [true, false].randomElement()!
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_L, ratio: 0.75)
    }

    func toModel() -> HouseListModel {
        let model = HouseListModel()
        model.id = id
        model.title = title
        model.address = address
        model.price = price
        model.size = size
        model.starRating = starRating
        model.subtitle = subtitle
        model.isBookmarked = isBookmarked
        model.photoURL = photoURL
        return model
    }
}

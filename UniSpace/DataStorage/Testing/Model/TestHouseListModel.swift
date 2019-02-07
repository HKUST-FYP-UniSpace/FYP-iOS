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
    var photoURL: String

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = "Clear Water Bay Deluxe"
        price = Int.random(in: 50..<200) * 100
        size = Int.random(in: 500..<1500)
        starRating = Int.random(in: 0..<6)
        subtitle = """
        It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way – in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.
        """
        address = "8 Clear Water Road, Clear Water Bay, N.T."
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
        model.photoURL = photoURL
        return model
    }
}

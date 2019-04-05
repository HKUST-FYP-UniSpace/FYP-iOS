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
    var starRating: Double
    var subtitle: String
    var address: String
    var isBookmarked: Bool
    var photoURLs: [String]
    var rooms: Int
    var beds: Int
    var toilets: Int

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = "Clear Water Bay Deluxe"
        price = Int.random(in: 50..<200) * 100
        size = Int.random(in: 500..<1500)
        starRating = Double.random(in: 0..<6)
        subtitle = Lorem.sentence()
        address = "8 Clear Water Road, Clear Water Bay, N.T."
        isBookmarked = Bool.random()
        photoURLs = []
        for _ in 0...Int.random(in: 2...10) {
            photoURLs.append(Constants.dummyPhotoURL(Constants.cardWidth_M, ratio: 0.75))
        }
        rooms = Int.random(in: 1..<6)
        beds = Int.random(in: 1..<6)
        toilets = Int.random(in: 1..<6)
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
        model.photoURLs = photoURLs
        model.rooms = rooms
        model.beds = beds
        model.toilets = toilets
        return model
    }
}

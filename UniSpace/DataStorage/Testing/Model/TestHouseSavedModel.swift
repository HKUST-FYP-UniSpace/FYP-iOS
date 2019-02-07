//
//  TestHouseSavedModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//
//
//import Foundation
//
//class TestHouseSavedModel: HouseSaved {
//
//    var id: Int
//    var title: String
//    var price: Int
//    var size: Int
//    var starRating: Int
//    var photoURL: String
//
//    required init() {
//        id = DataStore.shared.randomInt(length: 8)
//        title = "Clear Water Bay Deluxe"
//        price = Int.random(in: 50..<200) * 100
//        size = Int.random(in: 500..<1500)
//        starRating = Int.random(in: 0..<6)
//        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_M, ratio: 0.75)
//    }
//
//    func toModel() -> HouseSavedModel {
//        let model = HouseSavedModel()
//        model.id = id
//        model.title = title
//        model.price = price
//        model.size = size
//        model.starRating = starRating
//        model.photoURL = photoURL
//        return model
//    }
//}

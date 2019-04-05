//
//  TestHouseReviewModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 7/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestHouseReviewModel: HouseReview {

    var id: Int
    var username: String
    var title: String
    var date: Double
    var detail: String
    var starRating: Double
    var ownerId: Int
    var ownerComment: String
    var photoURL: String

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        username = ["Derek K.", "Jessi J.", "T'challa"].randomElement()!
        title = ["Team Awesome", "Warmest team you can find", "Funny Rommies!"].randomElement()!
        date = DateManager.shared.randomTime(30)
        detail = Lorem.paragraph()
        starRating = Double.random(in: 0..<6)
        ownerId = DataStore.shared.randomInt(length: 8)
        ownerComment = Lorem.paragraph()
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_S, ratio: 0.75)
    }

    func toModel() -> HouseReviewModel {
        let model = HouseReviewModel()
        model.id = id
        model.username = username
        model.title = title
        model.date = date
        model.detail = detail
        model.starRating = starRating
        model.ownerId = ownerId
        model.ownerComment = ownerComment
        model.photoURL = photoURL
        return model
    }
}

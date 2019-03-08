//
//  TestBlogSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestBlogSummaryModel: BlogSummary {

    var id: Int
    var title: String
    var subtitle: String
    var detail: String
    var photoURL: String
    var time: Double

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = "Get Started".uppercased()
        subtitle = ["How to Find the Perfect Apartment", "How to Survive the Apocalypse"].randomElement()!
        detail = Lorem.paragraphs()
        time = DateManager.shared.randomTime(30)
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_L, ratio: 0.75)
    }

    func toModel() -> BlogSummaryModel {
        let model = BlogSummaryModel()
        model.id = id
        model.title = title
        model.subtitle = subtitle
        model.detail = detail
        model.time = time
        model.photoURL = photoURL
        return model
    }
}

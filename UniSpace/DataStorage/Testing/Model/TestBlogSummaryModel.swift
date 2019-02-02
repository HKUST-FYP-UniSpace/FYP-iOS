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
    var subTitle: String
    var photoURL: String

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        title = "Get Started".uppercased()
        subTitle = ["How to Find the Perfect Apartment", "How to Survive the Apocalypse"].randomElement()!
        photoURL = Constants.dummyPhotoURL(60, ratio: 1)
    }

    func toModel() -> BlogSummaryModel {
        let model = BlogSummaryModel()
        model.id = id
        model.title = title
        model.subTitle = subTitle
        model.photoURL = photoURL
        return model
    }
}

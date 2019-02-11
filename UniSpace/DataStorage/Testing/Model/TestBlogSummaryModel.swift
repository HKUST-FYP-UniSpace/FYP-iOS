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
        detail = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam finibus a justo vel egestas. Nullam accumsan metus eu sem malesuada, in finibus purus cursus. Ut tempus ac odio ac semper. Nunc quam nisl, mollis ut enim eu, malesuada posuere eros. Suspendisse non magna ipsum. Etiam felis felis, varius eget lobortis auctor, elementum id justo. Quisque eu nisi condimentum, pellentesque leo vitae, porta ante. Sed ac nulla magna. Fusce rutrum faucibus pellentesque. Pellentesque pulvinar laoreet risus vel gravida. Vestibulum eu elit ut quam ullamcorper ultrices ornare vitae purus. Quisque vestibulum ante sit amet libero egestas, eget porta leo ultricies. Phasellus non mollis orci, at tempor mi. Nunc vel ex erat. Fusce nec leo non erat pretium laoreet. Suspendisse id est eu magna iaculis posuere quis vitae augue.

        Nam pellentesque tempus turpis vel pretium. Phasellus vestibulum faucibus dictum. Quisque et justo finibus, sodales nisi ut, ultricies mauris. Donec risus nisl, sollicitudin non elit a, porttitor tincidunt leo. Phasellus vitae turpis sit amet turpis fringilla efficitur. Praesent a eleifend enim. Donec congue libero vitae lorem tristique, in pretium lorem iaculis. Mauris gravida tempus bibendum.
        """
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

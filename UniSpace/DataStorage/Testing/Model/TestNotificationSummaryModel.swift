//
//  TestNotificationSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestNotificationSummaryModel: NotificationSummary {

    var id: Int = 0
    var title: String = ""
    var subtitle: String = ""
    var time: Double = 0
    var photoURL: String = ""

    required init(title: String, subtitle: String) {
        id = DataStore.shared.randomInt(length: 8)
        self.title = title
        self.subtitle = subtitle
        time = DateManager.shared.randomTime(1)
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_S, ratio: 1)
    }

    func toModel() -> NotificationSummaryModel {
        let model = NotificationSummaryModel()
        model.id = id
        model.title = title
        model.subtitle = subtitle
        model.time = time
        model.photoURL = photoURL
        return model
    }
}

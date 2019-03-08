//
//  TestMessageSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestMessageSummaryModel: MessageSummary {

    var id: Int = 0
    var title: String = ""
    var subtitle: String = ""
    var time: Double = 0
    var unreadMessagesCount: Int = 0
    var photoURL: String = ""
    var messageType: MessageGroupType = .Request

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        let type = MessageGroupType.allCases
        let randomNumber = Int.random(in: (0..<10))
        messageType = type.randomElement()!
        unreadMessagesCount = randomNumber % 2 == 0 ? 0 : randomNumber
        title = ["Derek K.", "Earth Mightiest Heros", "Jessi J.", "T'challa"].randomElement()!
        subtitle = Lorem.words()
        time = DateManager.shared.randomTime(30)
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_S, ratio: 1)
    }

    func toModel() -> MessageSummaryModel {
        let model = MessageSummaryModel()
        model.id = id
        model.title = title
        model.subtitle = subtitle
        model.time = time
        model.unreadMessagesCount = unreadMessagesCount
        model.photoURL = photoURL
        model.messageType = messageType
        return model
    }
}

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
    var subTitle: String = ""
    var time: Double = 0
    var unreadMessagesCount: Int = 0
    var photoURL: String = ""
    var messageType: MessageType = .Request

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        let type = MessageType.allCases
        let randomNumber = Int.random(in: (0..<30))
        messageType = type.randomElement()!
        unreadMessagesCount = randomNumber % 2 == 0 ? 0 : randomNumber
        title = ["Derek K.", "Earth Mightiest Heros", "Jessi J.", "T'challa"].randomElement()!
        subTitle = ["Hey bud, let's make a deal", "Wakanda Forever!", "Super long text that would need to be handled"].randomElement()!
        time = DateManager.shared.randomTime(30)
        photoURL = Constants.dummyPhotoURL(60, ratio: 1)
    }

    func toModel() -> MessageSummaryModel {
        let model = MessageSummaryModel()
        model.id = id
        model.title = title
        model.subTitle = subTitle
        model.time = time
        model.unreadMessagesCount = unreadMessagesCount
        model.photoURL = photoURL
        model.messageType = messageType
        return model
    }
}

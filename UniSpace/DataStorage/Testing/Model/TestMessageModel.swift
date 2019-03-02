//
//  TestMessageModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestMessageModel: Message {

    var id: Int
    var senderId: Int
    var message: String
    var time: Double

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        senderId = DataStore.shared.randomInt(length: 8)
        message = ["Hey bud, let's make a deal", "Wakanda Forever!", "Super long text that would need to be handled"].randomElement()!
        time = DateManager.shared.randomTime(30)
    }

    func toModel() -> MessageModel {
        let model = MessageModel()
        model.id = id
        model.senderId = senderId
        model.message = message
        model.time = time
        return model
    }
}

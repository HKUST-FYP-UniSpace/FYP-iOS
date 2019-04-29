//
//  TestMessageRequestModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 29/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestMessageRequestModel: MessageRequest {

    var isLeader: Bool
    var status: RequestStatus

    required init() {
        isLeader = Bool.random()
        status = RequestStatus.Pending
    }

    func toModel() -> MessageRequestModel {
        let model = MessageRequestModel()
        model.isLeader = isLeader
        model.status = status
        return model
    }
}

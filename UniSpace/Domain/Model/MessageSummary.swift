//
//  MessageSummary.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol MessageSummary: HavePhoto {

    var id: Int { get set }
    var title: String { get set }
    var subtitle: String { get set }
    var time: Double { get set }
    var unreadMessagesCount: Int { get set }
    var photoURL: String { get set }
    var messageType: MessageGroupType { get set }
    var users: [UserModel] { get set }
    var teamId: Int { get set }

}

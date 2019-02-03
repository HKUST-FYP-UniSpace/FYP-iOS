//
//  MessageSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class MessageSummaryModel: Decodable, ListDiffable, MessageSummary {

    var id: Int = 0
    var title: String = ""
    var subTitle: String = ""
    var time: Double = 0
    var unreadMessagesCount: Int = 0
    var photoURL: String = ""
    var messageType: MessageType = .Request

    init() {}

    required init(from decoder: Decoder) throws {

    }

    func diffIdentifier() -> NSObjectProtocol {
        return "\(id)" as NSString
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? MessageSummaryModel else { return false }
        return self.id == object.id
    }

    func readableTime() -> String {
        let date = Date(timeIntervalSince1970: time)
        if DateManager.shared.isToday(date) { return DateManager.shared.convertToTimeFormat(date: date) }
        let daysBefore = DateManager.shared.daysBeforeNow(date)
        return daysBefore < 2 ? "yesterday" : "\(daysBefore)d"
    }

}

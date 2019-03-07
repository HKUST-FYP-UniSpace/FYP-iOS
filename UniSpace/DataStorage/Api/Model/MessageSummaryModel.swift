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
    var subtitle: String = ""
    var time: Double = 0
    var unreadMessagesCount: Int = 0
    var photoURL: String = ""
    var messageType: MessageGroupType = .Request

    init() {}

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case time
        case unreadMessagesCount
        case photoURL
        case messageType
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        time = try container.decode(Double.self, forKey: .time)
        unreadMessagesCount = try container.decode(Int.self, forKey: .unreadMessagesCount)
        photoURL = try container.decode(String.self, forKey: .photoURL)
        let messageTypeInt = try container.decode(Int.self, forKey: .messageType)
        messageType = MessageGroupType(rawValue: messageTypeInt) ?? .Request
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
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

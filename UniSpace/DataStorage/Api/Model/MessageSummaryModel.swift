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
        id = DataStore.shared.randomInt(length: 8)
        decode(container, &title, type: String.self, forKey: .title)
        decode(container, &subtitle, type: String.self, forKey: .subtitle)
        decode(container, &time, type: Double.self, forKey: .time)
        decode(container, &unreadMessagesCount, type: Int.self, forKey: .unreadMessagesCount)
        decode(container, &photoURL, type: String.self, forKey: .photoURL)
        decode(container, &messageType, type: MessageGroupType.self, forKey: .messageType)
    }

    private func decode<T>(_ container: KeyedDecodingContainer<CodingKeys>, _ variable: inout T, type: T.Type, forKey key: CodingKeys) where T: Decodable {
        if let _variable = try? container.decode(type, forKey: key) {
            variable = _variable
        }
    }

    init() {}

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

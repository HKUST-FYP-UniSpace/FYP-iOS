//
//  MessageModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class MessageModel: Decodable, ListDiffable, Message {

    var id: Int = 0
    var senderId: Int = 0
    var message: String = ""
    var time: Double = 0

    enum CodingKeys: String, CodingKey {
        case id
        case senderId
        case message
        case time
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &senderId, type: Int.self, forKey: .senderId)
        decode(container, &message, type: String.self, forKey: .message)
        decode(container, &time, type: Double.self, forKey: .time)
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
        guard let object = object as? MessageModel else { return false }
        return self.id == object.id
    }

    func readableTime() -> String {
        let date = Date(timeIntervalSince1970: time)
        if DateManager.shared.isToday(date) { return DateManager.shared.convertToTimeFormat(date: date) }
        let daysBefore = DateManager.shared.daysBeforeNow(date)
        return daysBefore < 2 ? "yesterday" : "\(daysBefore)d"
    }

}

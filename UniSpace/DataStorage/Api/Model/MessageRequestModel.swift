//
//  MessageRequestModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 29/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class MessageRequestModel: Decodable, MessageRequest {

    var isLeader: Bool = false
    var status: RequestStatus = .Pending

    enum CodingKeys: String, CodingKey {
        case isLeader
        case status
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &isLeader, type: Bool.self, forKey: .isLeader)
        decode(container, &status, type: RequestStatus.self, forKey: .status)
    }

    private func decode<T>(_ container: KeyedDecodingContainer<CodingKeys>, _ variable: inout T, type: T.Type, forKey key: CodingKeys) where T: Decodable {
        if let _variable = try? container.decode(type, forKey: key) {
            variable = _variable
        }
    }

    init() {}

}

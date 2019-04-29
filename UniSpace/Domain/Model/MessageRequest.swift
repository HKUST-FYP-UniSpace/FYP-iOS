//
//  MessageRequest.swift
//  UniSpace
//
//  Created by KiKan Ng on 29/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol MessageRequest {

    var isLeader: Bool { get set }
    var status: RequestStatus { get set }

}

enum RequestStatus: Int, Codable, CaseIterable {
    case Pending = 0
    case Accepted
    case Denied


    init?(text: String?) {
        guard let text = text else { return nil }
        switch text {
        case RequestStatus.Pending.text: self = .Pending
        case RequestStatus.Accepted.text: self = .Accepted
        case RequestStatus.Denied.text: self = .Denied
        default: return nil
        }
    }

    var text: String {
        switch self {
        case .Pending: return "Pending"
        case .Accepted: return "Accepted"
        case .Denied: return "Denied"
        }
    }
}

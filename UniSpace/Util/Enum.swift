//
//  Enum.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

enum KeychainKeys: String {
    case username = "unispace-email"
    case password = "unispace-password"
    case token = "unispace-token"
}

enum UserDefaultKeys: String {
    case shouldSendToken = "unispace-should_send_token"
    case lastSync = "unispace-last_sync"
    case shouldNotSendNoti = "unispace-should_not_send_noti"
}

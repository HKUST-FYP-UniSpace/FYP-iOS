//
//  Enum.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

enum KeychainKeys: String {
    case username = "pentagon-email"
    case password = "pentagon-password"
    case token = "pentagon-token"
}

enum UserDefaultKeys: String {
    case shouldSendToken = "pentagon-should_send_token"
    case lastSync = "pentagon-last_sync"
    case shouldNotSendNoti = "pentagon-should_not_send_noti"
}

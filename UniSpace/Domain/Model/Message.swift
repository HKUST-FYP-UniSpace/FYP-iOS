//
//  Message.swift
//  UniSpace
//
//  Created by KiKan Ng on 28/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol Message {

    var id: Int { get set }
    var senderId: Int { get set }
    var message: String { get set }
    var time: Double { get set }

}

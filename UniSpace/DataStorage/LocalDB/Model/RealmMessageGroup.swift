//
//  RealmMessageGroup.swift
//  UniSpace
//
//  Created by KiKan Ng on 14/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import RealmSwift

class RealmMessageGroup: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var timestamp: Double = 0

    convenience required public init(id: Int, name: String, timestamp: Double) {
        self.init()
        self.id = id
        self.name = name
        self.timestamp = timestamp
    }

    override class func primaryKey() -> String? {
        return "id"
    }

}

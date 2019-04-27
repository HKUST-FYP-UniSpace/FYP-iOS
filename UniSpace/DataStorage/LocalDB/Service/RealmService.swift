//
//  RealmService.swift
//  UniSpace
//
//  Created by KiKan Ng on 14/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import RealmSwift

class RealmService {

    public var database = try! Realm()

    public static let shared: RealmService = RealmService()

    func deleteAll() {
        try? database.write {
            database.deleteAll()
        }
    }
}

// Message Group
extension RealmService {
    func persist(_ messageGroup: RealmMessageGroup) {
        try? database.write {
            database.add(messageGroup, update: true)
        }
    }

    func getMessageGroups() -> [RealmMessageGroup] {
        return Array(database.objects(RealmMessageGroup.self))
    }

    func getMessageGroup(_ id: Int) -> RealmMessageGroup? {
        return database.object(ofType: RealmMessageGroup.self, forPrimaryKey: id)
    }

    func deleteMessageGroups() {
        let objs = database.objects(RealmMessageGroup.self)
        for obj in objs { delete(obj) }
    }

    private func delete(_ object: RealmMessageGroup) {
        try? database.write {
            database.delete(object)
        }
    }
}

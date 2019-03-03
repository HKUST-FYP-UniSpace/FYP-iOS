//
//  NotificationSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class NotificationSummaryModel: Decodable, ListDiffable, NotificationSummary {

    var id: Int = 0
    var title: String = ""
    var subtitle: String = ""
    var time: Double = 0
    var photoURL: String = ""

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? NotificationSummaryModel else { return false }
        return self.id == object.id
    }

    func readableTime() -> String {
        let date = Date(timeIntervalSince1970: time)
        if DateManager.shared.isToday(date) { return DateManager.shared.convertToTimeFormat(date: date) }
        let daysBefore = DateManager.shared.daysBeforeNow(date)
        return daysBefore < 2 ? "yesterday" : "\(daysBefore)d"
    }

}

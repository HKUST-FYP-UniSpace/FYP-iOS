//
//  HouseReviewModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 7/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseReviewModel: Decodable, ListDiffable, HouseReview {
    
    var id: Int = 0
    var username: String = ""
    var title: String = ""
    var date: Double = 0
    var detail: String = ""
    var starRating: Double = 0
    var ownerId: Int = 0
    var ownerComment: String = ""
    var photoURL: String = ""

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseReviewModel else { return false }
        return self.id == object.id
    }

    func readableDate() -> String {
        let date = Date(timeIntervalSince1970: self.date)
        return DateManager.shared.convertToDateFormat(date: date)
    }

}

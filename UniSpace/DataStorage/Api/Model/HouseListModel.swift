//
//  HouseListModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseListModel: Decodable, ListDiffable, HouseList {

    var id: Int = 0
    var title: String = ""
    var price: Int = 0
    var size: Int = 0
    var starRating: Int = 0
    var subtitle: String = ""
    var address: String = ""
    var isBookmarked: Bool = false
    var photoURLs: [String] = []
    var rooms: Int = 0
    var beds: Int = 0
    var toilets: Int = 0

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseListModel else { return false }
        return self.id == object.id
    }

}

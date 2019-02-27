//
//  TradeFeaturedModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class TradeFeaturedModel: Decodable, ListDiffable, TradeFeatured {

    var id: Int = 0
    var title: String = ""
    var location: String = ""
    var price: Int = 0
    var status: String = ""
    var detail: String = ""
    var photoURL: String = ""

    init() {}

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? TradeFeaturedModel else { return false }
        return self.id == object.id
    }

    func allSet() -> Bool {
        return title != ""
            && location != ""
            && price != 0
            && detail != ""
    }

}

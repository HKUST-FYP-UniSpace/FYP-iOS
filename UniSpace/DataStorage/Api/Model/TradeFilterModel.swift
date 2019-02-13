//
//  TradeFilterModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TradeFilterModel {

    var keyword: String? = ""
    var searchBy: [String]? = []
    var category: [String]? = []
    var itemCondition: [String]? = []
    var maxPrice: Float? = nil
    var minPrice: Float? = nil
    var sortBy: String? = ""

    init() {}

}

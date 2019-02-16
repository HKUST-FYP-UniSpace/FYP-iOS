//
//  HouseFilterModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class HouseFilterModel {

    var keyword: String? = ""
    var university: University? = nil
    var maxPrice: Float? = nil
    var minPrice: Float? = nil
    var maxSize: Float? = nil
    var minSize: Float? = nil
    var maxTravelTime: Double? = nil
    var teamFormed: Bool? = false

    init() {}

}

enum University: String, CaseIterable {
    case HKU = "Hong Kong University"
    case CU = "Chinese University"
    case UST = "University of Science and Technology"
    case PolyU = "Hong Kong Polytechnic University"
    case CityU = "City University of Hong Kong"

    var pathExtension: String {
        switch self {
        case .HKU: return "hku"
        case .CU: return "cu"
        case .UST: return "ust"
        case .PolyU: return "poly_u"
        case .CityU: return "city_u"
        }
    }
}

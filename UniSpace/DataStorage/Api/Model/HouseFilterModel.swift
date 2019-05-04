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
    case HKU = "HKU"
    case CU = "CUHK"
    case UST = "HKUST"
    case PolyU = "PolyU"
    case CityU = "CityU"

    var pathExtension: String {
        switch self {
        case .HKU: return "The University of Hong Kong"
        case .CU: return "Chinese University of Hong Kong"
        case .UST: return "Hong Kong University of Science and Technology"
        case .PolyU: return "The Hong Kong Polytechnic University"
        case .CityU: return "City University of Hong Kong"
        }
    }
}

enum HouseType: String, CaseIterable {
    case Flat = "Flat"
    case Cottage = "Cottage"
    case Detached = "Detached"
    case SubDivided = "Sub-divided"

    var pathExtension: Int {
        switch self {
        case .Flat: return 0
        case .Cottage: return 1
        case .Detached: return 2
        case .SubDivided: return 3
        }
    }
}

//
//  TradeFilterModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TradeFilterModel {

    var keyword: String? = nil
    var searchBy: [TradeSearchBy]? = nil
    var category: [TradeCategory]? = nil
    var itemCondition: [TradeItemCondition]? = nil
    var maxPrice: Float? = nil
    var minPrice: Float? = nil
    var sortBy: TradeSortBy? = nil

    init() {}

}

enum TradeSearchBy: String, CaseIterable {
    case Title = "Title"
    case Seller = "Seller"

    var pathExtension: String {
        switch self {
        case .Title: return "title"
        case .Seller: return "seller"
        }
    }
}

enum TradeCategory: String, CaseIterable {
    case Kitchenwares = "Kitchenwares"
    case ElectronicsAndGadgets = "Electronics and Gadgets"
    case Furnitures = "Furnitures"

    var pathExtension: String {
        switch self {
        case .Kitchenwares: return "kitchenwares"
        case .ElectronicsAndGadgets: return "electronics_and_gadgets"
        case .Furnitures: return "furnitures"
        }
    }
}

enum TradeItemCondition: String, CaseIterable {
    case Perfect = "Perfect"
    case AlmostPerfect = "Almost Perfect"
    case Okay = "Okay"

    var pathExtension: String {
        switch self {
        case .Perfect: return "perfect"
        case .AlmostPerfect: return "almost_perfect"
        case .Okay: return "okay"
        }
    }
}

enum TradeSortBy: String, CaseIterable {
    case Recent = "Recent"
    case Top = "Top"
    case Hot = "Hot"

    var pathExtension: String {
        switch self {
        case .Recent: return "recent"
        case .Top: return "top"
        case .Hot: return "hot"
        }
    }
}

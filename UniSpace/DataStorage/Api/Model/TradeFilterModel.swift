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

enum TradeCategory: String, Codable, CaseIterable {
    case Kitchenwares = "Kitchenwares"
    case ElectronicsAndGadgets = "Electronics and Gadgets"
    case Furnitures = "Furnitures"
    case HealthAndBeauty = "Health and Beauty"
    case ToysAndGames = "Toys and Games"
    case BooksAndStationeries = "Books and Stationeries"
    case Fashion = "Fashion"
    case Sports = "Sports"

    var pathExtension: Int {
        switch self {
        case .Kitchenwares: return 1
        case .ElectronicsAndGadgets: return 2
        case .Furnitures: return 3
        case .HealthAndBeauty: return 4
        case .ToysAndGames: return 5
        case .BooksAndStationeries: return 6
        case .Fashion: return 7
        case .Sports: return 8
        }
    }
}

enum TradeItemCondition: String, Codable, CaseIterable {
    case Perfect = "Perfect"
    case AlmostPerfect = "Almost Perfect"
    case Okay = "Okay"
    case Worn = "Worn"

    var pathExtension: Int {
        switch self {
        case .Perfect: return 1
        case .AlmostPerfect: return 2
        case .Okay: return 3
        case .Worn: return 4
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

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
    case ElectronicsAndGadgets = "Electronics"
    case Furnitures = "Furnitures"
    case HealthAndBeauty = "Health and Beauty"
    case ToysAndGames = "Toys and Games"
    case Kitchenwares = "Kitchenwares"
    case BooksAndStationeries = "Books and Stationeries"
    case Fashion = "Fashion"
    case Sports = "Sports"

    var pathExtension: Int {
        switch self {
        case .ElectronicsAndGadgets: return 1
        case .Furnitures: return 2
        case .HealthAndBeauty: return 3
        case .ToysAndGames: return 4
        case .Kitchenwares: return 5
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

enum District: String, Codable, CaseIterable {
    case ClearWaterBay = "Clear Water Bay"
    case KwaiTsing = "Kwai Tsing"
    case North = "North"
    case SaiKung = "Sai Kung"
    case Shatin = "Shatin"
    case TaiPo = "Tai Po"
    case TsuenWan = "Tsuen Wan"
    case TuenMun = "Tuen Mun"
    case YuenLong = "Yuen Long"
    case KowloonCity = "Kowloon City"
    case KwunTong = "Kwun Tong"
    case ShamShuiPo = "Sham Shui Po"
    case WongTaiSin = "Wong Tai Sin"
    case YauTsimMong = "Yau Tsim Mong"
    case CentralWestern = "Central & Western"
    case Eastern = "Eastern"
    case Southern = "Southern"
    case WanChai = "Wan Chai"
    case SheungShui = "Sheung Shui"

    var pathExtension: Int {
        switch self {
        case .ClearWaterBay: return 1
        case .KwaiTsing: return 2
        case .North: return 3
        case .SaiKung: return 4
        case .Shatin: return 5
        case .TaiPo: return 6
        case .TsuenWan: return 7
        case .TuenMun: return 8
        case .YuenLong: return 9
        case .KowloonCity: return 10
        case .KwunTong: return 11
        case .ShamShuiPo: return 12
        case .WongTaiSin: return 13
        case .YauTsimMong: return 14
        case .CentralWestern: return 15
        case .Eastern: return 16
        case .Southern: return 17
        case .WanChai: return 18
        case .SheungShui: return 19
        }
    }
}

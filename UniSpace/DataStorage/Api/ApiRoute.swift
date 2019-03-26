//
//  ApiRoute.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

enum ApiRoute { case

    // auth
    authorize,
    register,
    verify(userId: Int),
    existUsername(username: String),

    // general
    getMyUserDetail,
    getUserProfile(userId: Int),
    getMessageSummaries,
    getNotificationSummaries,
    getBlogSummaries,
    getBlogDetail(blogId: Int),

    // owner
    getOwnerStatsSummary,

    // apartment
    getHouseSuggestions,
    getHouseSaved,
    getHouseList(filter: HouseFilterModel),
    getHouseView(houseId: Int),
    bookmarkHouse(houseId: Int),
    updatePreference,
    getTeamView(teamId: Int),
    createTeam(houseId: Int),
    createTeamImage(teamId: Int),
    joinTeam(teamId: Int),

    // trade
    getTradeFeatured,
    getTradeSellingItems,
    getTradeSaved,
    getTradeList(filter: TradeFilterModel),
    createTradeItem,
    createTradeItemImage(itemId: Int),
    getTradeDetail(itemId: Int),
    bookmarkItem(itemId: Int),
    contactOwner(itemId: Int),

    // log
    sendLogs
    
    var path: String {
        switch self {
        case .authorize:
            return "users/login"

        case .register:
            return "users/register"

        case .verify(let userId):
            return "users/verify/\(userId)"

//        case .existUsername(let username):
//            return ""
//
//        case .getMyUserDetail:
//            return ""

        case .getUserProfile(let userId):
            return "users/profile/\(userId)"

//        case .getMessageSummaries:
//            return ""
//
//        case .getNotificationSummaries:
//            return ""
//
//        case .getBlogSummaries:
//             return ""

        case .getBlogDetail(let blogId):
            return "blog/\(blogId)"

//        case .getOwnerStatsSummary:
//            return ""
//
//        case .getHouseSuggestions:
//            return ""

        case .getHouseSaved:
            return "houseBookmark"

        case .getHouseList(let filter):
            log.info("House Filter not handled", context: "\(filter)")
            return "house"

        case .getHouseView(let houseId):
            return "house/\(houseId)"

        case .bookmarkHouse(let houseId):
            return "houseBookmark/\(houseId)"

//        case .updatePreference:
//            return ""
//
//        case .getTeamView(let teamId):
//            return ""
//
//        case .createTeam(let houseId):
//            return ""
//
//        case .createTeamImage(let teamId):
//            return ""
//
//        case .joinTeam(let teamId):
//            return ""
//
//        case .getTradeFeatured:
//            return ""
//
//        case .getTradeSellingItems:
//            return ""

        case .getTradeSaved:
            return "tradeBookmark"

        case .getTradeList(let filter):
            log.info("Trade Filter not handled", context: "\(filter)")
            return "trade"

        case .createTradeItem:
            return "trade"

//        case .createTradeItemImage(let itemId):
//            return ""

        case .getTradeDetail(let itemId):
            return "trade/\(itemId)"

        case .bookmarkItem(let itemId):
            return "tradeBookmark/\(itemId)"

//        case .contactOwner(let itemId):
//            return ""
//
//        case .sendLogs:
//            return ""

        default:
            return ""
        }
        
    }
    
    func url() -> String {
        let host = "http://ec2-18-219-7-135.us-east-2.compute.amazonaws.com/api"
        return "\(host)/\(path)"
    }
}

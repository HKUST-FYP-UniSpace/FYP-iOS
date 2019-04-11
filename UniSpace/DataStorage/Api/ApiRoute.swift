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
    verify,
    existUsername,

    // general
    getMyUserDetail,
    getUserProfile,
    editUserProfile,
    getMessageSummaries,
    getNotificationSummaries,
    getCalendarSummaries,
    getBlogSummaries,
    getBlogDetail(blogId: Int),

    // owner
    getOwnerStatsSummary,

    // apartment
    getHouseSuggestions,
    getHouseSaved,
    getHouseList(filter: HouseFilterModel),
    getHouseView(houseId: Int),
    getHouseHistory,
    bookmarkHouse(houseId: Int),
    updatePreference,
    updateTeamPreference(teamId: Int),
    getTeamView(teamId: Int),
    createTeam(houseId: Int),
    createTeamImage(teamId: Int),
    joinTeam(teamId: Int),

    // trade
    getTradeFeatured,
    getTradeSellingItems,
    getTradeSaved,
    getTradeList(filter: TradeFilterModel),
    getTradeHistory,
    createTradeItem,
    createTradeItemImage(itemId: Int),
    getTradeDetail(itemId: Int),
    bookmarkItem(itemId: Int),
    contactOwner(itemId: Int),

    // log
    sendLogs
    
    var path: String {
        let userId = DataStore.shared.user?.id ?? -1
        switch self {
        case .authorize:
            return "users/login"

        case .register:
            return "users/register"

        case .verify:
            return "users/verify/\(userId)"

        case .existUsername:
            return "users/check/username"

//        case .getMyUserDetail:
//            return ""

        case .getUserProfile:
            return "users/profile/\(userId)"

        case .editUserProfile:
            return "users/profile/\(userId)/edit"

//        case .getMessageSummaries:
//            return ""
//
//        case .getNotificationSummaries:
//            return ""
//
//        case .getCalendarSummaries:
//            return ""

        case .getBlogSummaries:
             return "blog/summary"

        case .getBlogDetail(let blogId):
            return "blog/\(blogId)/detail"

//        case .getOwnerStatsSummary:
//            return ""

        case .getHouseSuggestions:
            return "house/\(userId)/suggestion"

        case .getHouseSaved:
            return "house/\(userId)/saved"

        case .getHouseList(let filter):
            log.info("House Filter not handled", context: "\(filter)")
            return "house/\(userId)/index"

        case .getHouseView(let houseId):
            return "house/\(userId)/houseView/\(houseId)"

        case .getHouseHistory:
            return "house/\(userId)/history"

        case .bookmarkHouse( _):
            return "houseBookmark"

        case .updatePreference:
            return "users/preference/\(userId)/edit"

        case .updateTeamPreference(let teamId):
            return "housePostGroup/\(teamId)/preference"

        case .getTeamView(let teamId):
            return "housePostGroup/\(teamId)"

        case .createTeam( _):
            return "housePostGroup"

        case .createTeamImage( _):
            return "housePostGroup/image/upload"

        case .joinTeam(let teamId):
            return "housePostGroup/\(teamId)/join"

//        case .getTradeFeatured:
//            return ""

        case .getTradeSellingItems:
            return "trade/\(userId)/selling"

        case .getTradeSaved:
            return "trade/\(userId)/bookmarked"

        case .getTradeList(let filter):
            log.info("Trade Filter not handled", context: "\(filter)")
            return "trade"

        case .getTradeHistory:
            return "trade/\(userId)/history"

        case .createTradeItem:
            return "trade"

        case .createTradeItemImage( _):
            return "trade/image/upload"

        case .getTradeDetail(let itemId):
            return "trade/\(userId)/trade/\(itemId)"

        case .bookmarkItem( _):
            return "tradeBookmark"

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

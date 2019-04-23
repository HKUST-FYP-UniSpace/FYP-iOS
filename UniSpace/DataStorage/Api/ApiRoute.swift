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
    sendEmail,
    existUsername,

    // general
    getUserProfile,
    editUserProfile,
    getMessageSummaries,
    getMessageDetails(messageId: Int),
    getNotificationSummaries,
    getCalendarSummaries(year: Int, month: Int),
    getBlogSummaries,
    getBlogDetail(blogId: Int),

    // owner
    getOwnerStatsSummary,
    getOwnerHouseSummary,
    getOwnerTeamSummary(houseId: Int),
    replyReview(reviewId: Int),

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
    addReview(houseId: Int),

    // trade
    getTradeFeatured,
    getTradeSellingItems,
    getTradeSaved,
    getTradeList(filter: TradeFilterModel),
    getTradeHistory,
    createTradeItem,
    createTradeItemImage(itemId: Int),
    editTradeItem(itemId: Int),
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

        case .sendEmail:
            return "users/verify/\(userId)/email"

        case .existUsername:
            return "users/check/username"

        case .getUserProfile:
            return "users/profile/\(userId)"

        case .editUserProfile:
            return "users/profile/\(userId)/edit"

//        case .getMessageSummaries:
//            return ""
//
//        case .getMessageDetails(let messageId):
//            return ""
//
//        case .getNotificationSummaries:
//            return ""

        case .getCalendarSummaries(let year, let month):
            return "users/calendar/\(userId)/\(year)/\(month)"

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

        case .addReview(let houseId):
            return "house/\(houseId)/review"

        case .getTradeFeatured:
            return "trade/\(userId)/featured"

        case .getTradeSellingItems:
            return "trade/\(userId)/selling"

        case .getTradeSaved:
            return "trade/\(userId)/bookmarked"

        case .getTradeList(let filter):
            var queryString = "trade/\(userId)/index?"
            if let keyword = filter.keyword, let value = filter.searchBy, !value.isEmpty {
                value.forEach { (search) in queryString += "\(search.pathExtension)=\(keyword)&" }
            } else {
                queryString += "\(TradeSearchBy.Title.pathExtension)=\(filter.keyword ?? "")&"
            }
            if let value = filter.minPrice { queryString += "minPrice=\(value)&" }
            if let value = filter.maxPrice { queryString += "maxPrice=\(value)&" }
            if let value = filter.category, !value.isEmpty {
                value.forEach { (cat) in queryString += "category[]=\(cat.pathExtension)&" }
            }
            if let value = filter.itemCondition, !value.isEmpty {
                value.forEach { (condition) in queryString += "itemCondition[]=\(condition.pathExtension)&" }
            }
            return String(queryString.dropLast())

        case .getTradeHistory:
            return "trade/\(userId)/history"

        case .createTradeItem:
            return "trade"

        case .createTradeItemImage( _):
            return "trade/image/upload"

        case .editTradeItem(let itemId):
            return "trade/\(userId)/update/\(itemId)"

        case .getTradeDetail(let itemId):
            return "trade/\(userId)/detail/\(itemId)"

        case .bookmarkItem( _):
            return "tradeBookmark"

//        case .contactOwner(let itemId):
//            return ""

        case .getOwnerHouseSummary:
            return "owner/\(userId)/houseSummary"

        case .getOwnerTeamSummary(let houseId):
            return "owner/\(userId)/teamSummary/\(houseId)"

        case .replyReview(let reviewId):
            return "owner/\(reviewId)/reply"

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

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
    createOwnerChatroom,
    createTeamChatroom,
    createTradeChatroom,
    createRequestChatroom,
    createAdminChatroom,
    sendMessage(messageId: Int),
    getRequestStatus(messageId: Int),
    changeRequestStatus(messageId: Int),
    getNotificationSummaries,
    getCalendarSummaries(year: Int, month: Int),
    getBlogSummaries,
    getBlogDetail(blogId: Int),

    // owner
    getOwnerStatsSummary,
    getOwnerHouseSummary,
    getOwnerTeamSummary(houseId: Int),
    replyReview(reviewId: Int),
    getHouseData(houseId: Int, filter: ChartFilterOptions),
    createHouse,
    createHouseImage(houseId: Int),
    editHouse(houseId: Int),
    changeHouseStatus(houseId: Int),

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
    getTradeItemData(itemId: Int, filter: ChartFilterOptions),
    getTradeDetail(itemId: Int),
    bookmarkItem(itemId: Int),

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

        case .getMessageSummaries:
            return "message/\(userId)"

        case .getMessageDetails(let messageId):
            return "message/\(userId)/\(messageId)"

        case .createOwnerChatroom:
            return "message/\(userId)/owner"

        case .createTeamChatroom:
            return ""

        case .createTradeChatroom:
            return "message/\(userId)/trade"

        case .createRequestChatroom:
            return ""

        case .createAdminChatroom:
            return "message/\(userId)/admin"

        case .sendMessage(let messageId):
            return "message/\(userId)/\(messageId)"

        case .getRequestStatus(let messageId):
            return "message/\(userId)/\(messageId)/role"

        case .changeRequestStatus(let messageId):
            return "housePostGroup/\(messageId)/approve"

        case .getNotificationSummaries:
            return ""

        case .getCalendarSummaries(let year, let month):
            return "users/calendar/\(userId)/\(year)/\(month)"

        case .getBlogSummaries:
            return "blog/summary"

        case .getBlogDetail(let blogId):
            return "blog/\(blogId)/detail"

        case .getOwnerStatsSummary:
            return "owner/\(userId)/houseSummary"

        case .getHouseSuggestions:
            return "house/\(userId)/suggestion"

        case .getHouseSaved:
            return "house/\(userId)/saved"

        case .getHouseList(let filter):
            var queryString = "house/\(userId)/index?"
            if let value = filter.keyword { queryString += "keyword=\(value)&" }
            if let travelTime = filter.maxTravelTime, let origin = filter.university {
                queryString += "travelTime=\(travelTime)&"
                queryString += "origin=\(origin.pathExtension)&"
            }
            if let value = filter.minPrice { queryString += "minPrice=\(Int(value))&" }
            if let value = filter.maxPrice { queryString += "maxPrice=\(Int(value))&" }
            if let value = filter.minSize { queryString += "minSize=\(Int(value))&" }
            if let value = filter.maxSize { queryString += "maxSize=\(Int(value))&" }
            if let value = filter.teamFormed { queryString += "teamFormed=\(value ? 1 : 0)&" }
            return String(queryString.dropLast()).replacingOccurrences(of: " ", with: "%20")

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
            if let value = filter.minPrice { queryString += "minPrice=\(Int(value))&" }
            if let value = filter.maxPrice { queryString += "maxPrice=\(Int(value))&" }
            if let value = filter.category, !value.isEmpty {
                value.forEach { (cat) in queryString += "category[]=\(cat.pathExtension)&" }
            }
            if let value = filter.itemCondition, !value.isEmpty {
                value.forEach { (condition) in queryString += "itemCondition[]=\(condition.pathExtension)&" }
            }
            return String(queryString.dropLast()).replacingOccurrences(of: " ", with: "%20")

        case .getTradeHistory:
            return "trade/\(userId)/history"

        case .createTradeItem:
            return "trade"

        case .createTradeItemImage( _):
            return "trade/image/upload"

        case .editTradeItem(let itemId):
            return "trade/\(userId)/update/\(itemId)"

        case .getTradeItemData(let itemId, let filter):
            return "trade/\(userId)/tradeData/\(itemId)/view/\(filter.rawValue)"

        case .getTradeDetail(let itemId):
            return "trade/\(userId)/detail/\(itemId)"

        case .bookmarkItem( _):
            return "tradeBookmark"

        case .getOwnerHouseSummary:
            return "owner/\(userId)/houseSummary"

        case .getOwnerTeamSummary(let houseId):
            return "owner/\(userId)/teamSummary/\(houseId)"

        case .replyReview(let reviewId):
            return "owner/\(reviewId)/reply"

        case .getHouseData(let houseId, let filter):
            return "owner/\(userId)/houseData/\(houseId)/view/\(filter.rawValue)"

        case .createHouse:
            return "owner/house/add"

        case .createHouseImage(_):
            return "owner/house/img"

        case .editHouse(_):
            return "owner/house/update"

        case .changeHouseStatus(let houseId):
            return "owner/\(houseId)/houseStatus"

        case .sendLogs:
            return ""

        }
        
    }
    
    func url() -> String {
        let host = "http://ec2-18-219-7-135.us-east-2.compute.amazonaws.com/api"
        return "\(host)/\(path)"
    }
}

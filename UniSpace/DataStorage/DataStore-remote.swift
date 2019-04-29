//
//  DataStore+Auth.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit
import MessageKit

extension DataStore {
    
    func authorize(completion: @escaping (UserModel?, Error?) -> ()) {
        Service().authorize(completion: completion)
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (UserModel?, Error?) -> ()) {
        Service().register(userType: userType, username: username, name: name, email: email, password: password, completion: completion)
    }

    func sendVerificationEmail(completion: SendRequestResult?) {
        Service().sendVerificationEmail(completion: completion)
    }
    
    func verify(code: String, completion: @escaping (UserModel?, Error?) -> ()) {
        Service().verify(code: code, completion: completion)
    }

    func existUsername(username: String, completion: @escaping (_ exist: Bool?, _ error: Error?) -> Void) {
        Service().existUsername(username: username, completion: completion)
    }
    
    func getUserProfile(userId: Int? = nil, completion: @escaping (UserModel?, Error?) -> ()) {
        let id = (userId == nil) ? (DataStore.shared.user?.id ?? -1) : userId!
        Service().getUserProfile(userId: id, completion: completion)
    }

    func editUserProfile(userProfile: UserModel, image: UIImage, completion: SendRequestResult?) {
        Service().editUserProfile(userProfile: userProfile, image: image, completion: completion)
    }

    func getMessageSummaries(completion: @escaping ([MessageSummaryModel]?, Error?) -> ()) {
        Service().getMessageSummaries(completion: completion)
    }

    func getMessageDetails(messageId: Int, allowedUsers: [UserModel], completion: @escaping ([MockMessage]?, Error?) -> Void) {
        Service().getMessageDetails(messageId: messageId, allowedUsers: allowedUsers, completion: completion)
    }

    func createNewMessageGroup(type: MessageGroupType, message: MockMessage, teamId: Int? = nil, itemId: Int? = nil, completion: SendRequestResult?) {
        Service().createNewMessageGroup(type: type, message: message, teamId: teamId, itemId: itemId, completion: completion)
    }

    func addNewMessage(messageId: Int, message: String, completion: SendRequestResult?) {
        Service().addNewMessage(messageId: messageId, message: message, completion: completion)
    }

    func getRequestStatus(messageId: Int, completion: @escaping (MessageRequestModel?, Error?) -> Void) {
        Service().getRequestStatus(messageId: messageId, completion: completion)
    }

    func changeRequestStatus(messageId: Int, status: RequestStatus, completion: SendRequestResult?) {
        Service().changeRequestStatus(messageId: messageId, status: status, completion: completion)
    }

    func getNotificationSummaries(completion: @escaping ([NotificationSummaryModel]?, Error?) -> Void) {
        Service().getNotificationSummaries(completion: completion)
    }

    func getCalendarSummaries(year: Int, month: Int, completion: @escaping ([CalendarDataListModel]?, Error?) -> Void) {
        Service().getCalendarSummaries(year: year, month: month, completion: completion)
    }

    func getBlogSummaries(completion: @escaping (_ summaries: [BlogSummaryModel]?, _ error: Error?) -> ()) {
        Service().getBlogSummaries(completion: completion)
    }

    func getBlogDetail(blogId: Int, completion: @escaping (BlogSummaryModel?, Error?) -> Void) {
        Service().getBlogDetail(blogId: blogId, completion: completion)
    }

    func getHouseSuggestions(completion: @escaping (_ summaries: [HouseSuggestionModel]?, _ error: Error?) -> ()) {
        Service().getHouseSuggestions(completion: completion)
    }

    func getHouseSaved(completion: @escaping (_ summaries: [HouseListModel]?, _ error: Error?) -> ()) {
        Service().getHouseSaved(completion: completion)
    }

    func getHouseHistory(completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        Service().getHouseHistory(completion: completion)
    }

    func getHouseList(filter: HouseFilterModel?, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        Service().getHouseList(filter: filter ?? HouseFilterModel(), completion: completion)
    }

    func getHouseView(houseId: Int, completion: @escaping (_ model: HouseViewModel?, _ error: Error?) -> Void) {
        Service().getHouseView(houseId: houseId, completion: completion)
    }

    func bookmarkHouse(houseId: Int, bookmarked: Bool, completion: SendRequestResult?) {
        Service().bookmarkHouse(houseId: houseId, bookmarked: bookmarked, completion: completion)
    }

    func addReview(houseId: Int, review: HouseReviewModel, completion: SendRequestResult?) {
        Service().addReview(houseId: houseId, review: review, completion: completion)
    }

    func changePreference(userId: Int? = nil, preference: PreferenceModel, completion: SendRequestResult?) {
        Service().changePreference(preference: preference, completion: completion)
    }

    func changeTeamPreference(teamId: Int, preference: PreferenceModel, completion: SendRequestResult?) {
        Service().changeTeamPreference(teamId: teamId, preference: preference, completion: completion)
    }

    func createTeam(houseId: Int, model: HouseTeamSummaryModel, image: UIImage, completion: SendRequestResult?) {
        Service().createTeam(houseId: houseId, model: model, image: image, completion: completion)
    }

    func joinTeam(teamId: Int, completion: SendRequestResult?) {
        Service().joinTeam(teamId: teamId, completion: completion)
    }

    func getTeamView(teamId: Int, completion: @escaping (TeamSummaryViewModel?, Error?) -> Void) {
        Service().getTeamView(teamId: teamId, completion: completion)
    }

    func getTradeFeatured(completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> ()) {
        Service().getTradeFeatured(completion: completion)
    }

    func getTradeSellingItems(completion: @escaping (_ summaries: [TradeSellingItemModel]?, _ error: Error?) -> ()) {
        Service().getTradeSellingItems(completion: completion)
    }

    func getTradeSaved(completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> ()) {
        Service().getTradeSaved(completion: completion)
    }

    func getTradeHistory(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        Service().getTradeHistory(completion: completion)
    }

    func getTradeList(filter: TradeFilterModel?, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        Service().getTradeList(filter: filter ?? TradeFilterModel(), completion: completion)
    }

    func createTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        Service().createTradeItem(model: model, images: images, completion: completion)
    }

    func editTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        Service().editTradeItem(model: model, images: images, completion: completion)
    }

    func getTradeItemData(itemId: Int, filter: ChartFilterOptions, completion: @escaping (ChartDataListModel?, Error?) -> Void) {
        Service().getTradeItemData(itemId: itemId, filter: filter, completion: completion)
    }

    func getTradeDetail(itemId: Int, completion: @escaping (TradeFeaturedModel?, Error?) -> Void) {
        Service().getTradeDetail(itemId: itemId, completion: completion)
    }

    func bookmarkItem(itemId: Int, bookmarked: Bool, completion: SendRequestResult?) {
        Service().bookmarkItem(itemId: itemId, bookmarked: bookmarked, completion: completion)
    }

    func getOwnerHouseSummary(completion: @escaping ([OwnerHouseSummaryModel]?, Error?) -> Void) {
        Service().getOwnerHouseSummary(completion: completion)
    }

    func getOwnerTeamsSummary(houseId: Int, completion: @escaping (OwnerTeamsModel?, Error?) -> Void) {
        Service().getOwnerTeamsSummary(houseId: houseId, completion: completion)
    }

    func replyReivew(reviewId: Int, comment: String, completion: SendRequestResult?) {
        Service().replyReivew(reviewId: reviewId, comment: comment, completion: completion)
    }

    func getHouseData(houseId: Int, filter: ChartFilterOptions, completion: @escaping (ChartDataListModel?, Error?) -> Void) {
        Service().getHouseData(houseId: houseId, filter: filter, completion: completion)
    }

    func createHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?) {
        Service().createHouse(model: model, images: images, completion: completion)
    }

    func editHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?) {
        Service().editHouse(model: model, images: images, completion: completion)
    }

    func changeHouseStatus(houseId: Int, status: HouseStatus, completion: SendRequestResult?) {
        Service().changeHouseStatus(houseId: houseId, status: status, completion: completion)
    }
    
}

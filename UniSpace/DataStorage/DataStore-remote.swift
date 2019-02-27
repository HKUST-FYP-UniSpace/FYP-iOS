//
//  DataStore+Auth.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

extension DataStore {
    
    func authorize(completion: @escaping (UserModel?, Error?) -> ()) {
        Service().authorize(completion: completion)
    }
    
    func register(userType: UserType, username: String, name: String, email: String, password: String, completion: @escaping (UserModel?, Error?) -> ()) {
        Service().register(userType: userType, username: username, name: name, email: email, password: password, completion: completion)
    }
    
    func verify(userId: Int, code: String, completion: @escaping (UserModel?, Error?) -> ()) {
        Service().verify(userId: userId, code: code, completion: completion)
    }
    
    func getUserProfile(userId: Int? = nil, completion: @escaping (UserProfileModel?, Error?) -> ()) {
        let id = (userId == nil) ? (DataStore.shared.user?.id ?? -1) : userId!
        Service().getUserProfile(userId: id, completion: completion)
    }

    func getMessageSummaries(completion: @escaping ([MessageSummaryModel]?, Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getMessageSummaries(userId: userId, completion: completion)
    }

    func getNotificationSummaries(completion: @escaping ([NotificationSummaryModel]?, Error?) -> Void) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getNotificationSummaries(userId: userId, completion: completion)
    }

    func getBlogSummaries(completion: @escaping (_ summaries: [BlogSummaryModel]?, _ error: Error?) -> ()) {
        Service().getBlogSummaries(completion: completion)
    }

    func getBlogDetail(blogId: Int, completion: @escaping (BlogSummaryModel?, Error?) -> Void) {
        Service().getBlogDetail(blogId: blogId, completion: completion)
    }

    func getHouseSuggestions(completion: @escaping (_ summaries: [HouseSuggestionModel]?, _ error: Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getHouseSuggestions(userId: userId, completion: completion)
    }

    func getHouseSaved(completion: @escaping (_ summaries: [HouseListModel]?, _ error: Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getHouseSaved(userId: userId, completion: completion)
    }

    func getHouseList(filter: HouseFilterModel?, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getHouseList(userId: userId, filter: filter ?? HouseFilterModel(), completion: completion)
    }

    func getHouseView(houseId: Int, completion: @escaping (_ model: HouseViewModel?, _ error: Error?) -> Void) {
        Service().getHouseView(houseId: houseId, completion: completion)
    }

    func bookmarkHouse(houseId: Int, completion: SendRequestResult?) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().bookmarkHouse(userId: userId, houseId: houseId, completion: completion)
    }

    func changePreference(userId: Int? = nil, preference: PreferenceModel, completion: SendRequestResult?) {
        let id = (userId == nil) ? (DataStore.shared.user?.id ?? -1) : userId!
        Service().changePreference(userId: id, preference: preference, completion: completion)
    }

    func createTeam(houseId: Int, model: HouseTeamSummaryModel, image: UIImage, completion: SendRequestResult?) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().createTeam(userId: userId, houseId: houseId, model: model, image: image, completion: completion)
    }

    func joinTeam(teamId: Int, completion: SendRequestResult?) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().joinTeam(userId: userId, teamId: teamId, completion: completion)
    }

    func getTeamView(teamId: Int, completion: @escaping (TeamSummaryViewModel?, Error?) -> Void) {
        Service().getTeamView(teamId: teamId, completion: completion)
    }

    func getTradeFeatured(completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getTradeFeatured(userId: userId, completion: completion)
    }

    func getTradeSellingItems(completion: @escaping (_ summaries: [TradeSellingItemModel]?, _ error: Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getTradeSellingItems(userId: userId, completion: completion)
    }

    func getTradeSaved(completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getTradeSaved(userId: userId, completion: completion)
    }

    func getTradeList(filter: TradeFilterModel?, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getTradeList(userId: userId, filter: filter ?? TradeFilterModel(), completion: completion)
    }
    
}

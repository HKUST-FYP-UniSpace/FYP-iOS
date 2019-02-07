//
//  DataStore+Auth.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

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
    
    func getUserProfile(completion: @escaping (UserProfileModel?, Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getUserProfile(userId: userId, completion: completion)
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

    func getHouseSuggestions(completion: @escaping (_ summaries: [HouseSuggestionModel]?, _ error: Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getHouseSuggestions(userId: userId, completion: completion)
    }

    func getHouseSaved(completion: @escaping (_ summaries: [HouseListModel]?, _ error: Error?) -> ()) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getHouseSaved(userId: userId, completion: completion)
    }

    func getHouseList(completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        let userId = DataStore.shared.user?.id ?? -1
        Service().getHouseList(userId: userId, completion: completion)
    }

    func getHouseView(houseId: Int, completion: @escaping (_ model: HouseViewModel?, _ error: Error?) -> Void) {
        Service().getHouseView(houseId: houseId, completion: completion)
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

    func getTradeCategories(completion: @escaping (_ summaries: [TradeCategoryModel]?, _ error: Error?) -> ()) {
        Service().getTradeCategories(completion: completion)
    }
    
}

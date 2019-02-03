//
//  TestService+Trade.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: TradeService {

    func getTradeFeatured(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        var summaries: [TradeFeaturedModel]? = []
        for _ in 0..<4 { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeSellingItems(userId: Int, completion: @escaping ([TradeSellingItemModel]?, Error?) -> Void) {
        var summaries: [TradeSellingItemModel]? = []
        for _ in 0..<2 { summaries?.append(TestTradeSellingItemModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeSaved(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        var summaries: [TradeFeaturedModel]? = []
        for _ in 0..<3 { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeCategories(completion: @escaping ([TradeCategoryModel]?, Error?) -> Void) {
        var categories: [TradeCategoryModel]? = []
        categories?.append(TestTradeCategoryModel(title: "Electronics and Gadgets", pathExtention: "electronics-and-gadgets").toModel())
        categories?.append(TestTradeCategoryModel(title: "Furnitures", pathExtention: "furnitures").toModel())
        categories?.append(TestTradeCategoryModel(title: "Kitchenwares", pathExtention: "kitchenwares").toModel())
        delay { completion(categories, nil) }
    }


}

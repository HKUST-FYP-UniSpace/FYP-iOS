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
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeSellingItems(userId: Int, completion: @escaping ([TradeSellingItemModel]?, Error?) -> Void) {
        var summaries: [TradeSellingItemModel]? = []
        for _ in 0..<Int.random(in: (2..<10)) { summaries?.append(TestTradeSellingItemModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeSaved(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        var summaries: [TradeFeaturedModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeList(userId: Int, filter: TradeFilterModel, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        var summaries: [TradeFeaturedModel]? = []
        for _ in 0..<Int.random(in: (1..<30)) { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }


}

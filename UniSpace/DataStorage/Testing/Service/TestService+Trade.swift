//
//  TestService+Trade.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

extension TestService: TradeService {

    func getTradeFeatured(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        var summaries: [TradeFeaturedModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeSellingItems(completion: @escaping ([TradeSellingItemModel]?, Error?) -> Void) {
        var summaries: [TradeSellingItemModel]? = []
        for _ in 0..<Int.random(in: (2..<10)) { summaries?.append(TestTradeSellingItemModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeSaved(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        var summaries: [TradeFeaturedModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeHistory(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        var summaries: [TradeFeaturedModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getTradeList(filter: TradeFilterModel, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        var summaries: [TradeFeaturedModel]? = []
        for _ in 0..<Int.random(in: (1..<30)) { summaries?.append(TestTradeFeaturedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func createTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

    func editTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

    func getTradeItemData(itemId: Int, filter: ChartFilterOptions, completion: @escaping (ChartDataListModel?, Error?) -> Void) {
        let data: ChartDataListModel? = ChartDataListModel()
        for i in 0..<filter.dataCount {
            let newData = TestChartDataModel()
            newData.setup(order: i)
            data?.targetViews.append(newData.toModel())
            newData.reRandomize()
            data?.othersViews.append(newData.toModel())
            newData.reRandomize()
            data?.targetBookmarks.append(newData.toModel())
            newData.reRandomize()
            data?.othersBookmarks.append(newData.toModel())
        }
        delay { completion(data, nil) }
    }

    func getTradeDetail(itemId: Int, completion: @escaping (TradeFeaturedModel?, Error?) -> Void) {
        delay { completion(TestTradeFeaturedModel().toModel(), nil) }
    }

    func bookmarkItem(itemId: Int, bookmarked: Bool, completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

}

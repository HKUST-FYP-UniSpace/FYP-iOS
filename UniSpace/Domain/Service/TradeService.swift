//
//  TradeService.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

protocol TradeService: class {

    func getTradeFeatured(completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func getTradeSellingItems(completion: @escaping (_ summaries: [TradeSellingItemModel]?, _ error: Error?) -> Void)
    func getTradeSaved(completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func getTradeHistory(completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func getTradeList(filter: TradeFilterModel, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func createTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?)
    func editTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?)
    func getTradeItemData(itemId: Int, filter: ChartFilterOptions, completion: @escaping (_ data: ChartDataListModel?, _ error: Error?) -> Void)
    func getTradeDetail(itemId: Int, completion: @escaping (_ model: TradeFeaturedModel?, _ error: Error?) -> Void)
    func bookmarkItem(itemId: Int, bookmarked: Bool, completion: SendRequestResult?)
}

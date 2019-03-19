//
//  TradeService.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

protocol TradeService: class {

    func getTradeFeatured(userId: Int, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func getTradeSellingItems(userId: Int, completion: @escaping (_ summaries: [TradeSellingItemModel]?, _ error: Error?) -> Void)
    func getTradeSaved(userId: Int, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func getTradeHistory(userId: Int, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func getTradeList(userId: Int, filter: TradeFilterModel, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func createTradeItem(userId: Int, model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?)
    func getTradeDetail(itemId: Int, completion: @escaping (_ model: TradeFeaturedModel?, _ error: Error?) -> Void)
    func bookmarkItem(userId: Int, itemId: Int, completion: SendRequestResult?)
    func contactOwner(userId: Int, itemId: Int, message: String, completion: SendRequestResult?)
}

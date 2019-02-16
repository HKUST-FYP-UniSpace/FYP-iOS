//
//  TradeService.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol TradeService: class {

    func getTradeFeatured(userId: Int, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func getTradeSellingItems(userId: Int, completion: @escaping (_ summaries: [TradeSellingItemModel]?, _ error: Error?) -> Void)
    func getTradeSaved(userId: Int, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
    func getTradeList(userId: Int, filter: TradeFilterModel, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> Void)
}

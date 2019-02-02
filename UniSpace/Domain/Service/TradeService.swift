//
//  TradeService.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol TradeService: class {

    func getTradeFeatured(userId: Int, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> ())
    func getTradeSellingItems(userId: Int, completion: @escaping (_ summaries: [TradeSellingItemModel]?, _ error: Error?) -> ())
    func getTradeSaved(userId: Int, completion: @escaping (_ summaries: [TradeFeaturedModel]?, _ error: Error?) -> ())
    func getTradeCategories(completion: @escaping (_ summaries: [TradeCategoryModel]?, _ error: Error?) -> ())
}
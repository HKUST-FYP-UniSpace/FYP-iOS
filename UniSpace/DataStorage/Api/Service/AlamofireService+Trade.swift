//
//  AlamofireService+Trade.swift
//  
//
//  Created by KiKan Ng on 2/2/2019.
//

import Alamofire

extension AlamofireService: TradeService {

    func getTradeFeatured(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        completion(nil, nil)
    }

    func getTradeSellingItems(userId: Int, completion: @escaping ([TradeSellingItemModel]?, Error?) -> Void) {
        completion(nil, nil)
    }

    func getTradeSaved(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        completion(nil, nil)
    }

    func getTradeList(userId: Int, filter: TradeFilterModel, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        completion(nil, nil)
    }

}

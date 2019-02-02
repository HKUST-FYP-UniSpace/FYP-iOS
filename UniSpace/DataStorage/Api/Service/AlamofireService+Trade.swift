//
//  AlamofireService+Trade.swift
//  
//
//  Created by KiKan Ng on 2/2/2019.
//

import Alamofire

extension AlamofireService: TradeService {

    func getTradeFeatured(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> ()) {
        completion(nil, nil)
    }

    func getTradeSellingItems(userId: Int, completion: @escaping ([TradeSellingItemModel]?, Error?) -> ()) {
        completion(nil, nil)
    }

    func getTradeSaved(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> ()) {
        completion(nil, nil)
    }

    func getTradeCategories(completion: @escaping ([TradeCategoryModel]?, Error?) -> ()) {
        completion(nil, nil)
    }

}

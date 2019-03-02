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

    func createTradeItem(userId: Int, model: TradeFeaturedModel, image: UIImage, completion: SendRequestResult?) {
        completion?(nil, nil)
    }

    func getTradeDetail(itemId: Int, completion: @escaping (TradeFeaturedModel?, Error?) -> Void) {
        completion(nil, nil)
    }

    func bookmarkItem(userId: Int, itemId: Int, completion: SendRequestResult?) {
        completion?(nil, nil)
    }

    func contactOwner(userId: Int, itemId: Int, message: String, completion: SendRequestResult?) {
//        let senderId = DataStore.shared.user?.id ?? -1
//        let time = DateManager.shared.getCurrentDate().timeIntervalSince1970
        completion?(nil, nil)
    }

}

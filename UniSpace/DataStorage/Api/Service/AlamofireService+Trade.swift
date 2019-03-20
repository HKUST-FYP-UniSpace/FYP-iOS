//
//  AlamofireService+Trade.swift
//  
//
//  Created by KiKan Ng on 2/2/2019.
//

import Alamofire

extension AlamofireService: TradeService {

    func getTradeFeatured(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeFeatured()).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getTradeSellingItems(userId: Int, completion: @escaping ([TradeSellingItemModel]?, Error?) -> Void) {
        get(at: .getTradeSellingItems()).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeSellingItemModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeSellingItemModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getTradeSaved(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeSaved()).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getTradeHistory(userId: Int, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        // TODO
    }

    func getTradeList(userId: Int, filter: TradeFilterModel, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeList(filter: filter)).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func createTradeItem(userId: Int, model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        let params = getItemParams(model)
        post(at: .updatePreference(), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
            // TODO: send image
        }
    }

    func editTradeItem(userId: Int, model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        // TODO
    }

    func getTradeDetail(itemId: Int, completion: @escaping (TradeFeaturedModel?, Error?) -> Void) {
        get(at: .getTradeDetail(itemId: itemId)).responseJSON { (res: DataResponse<Any>) in
            var result: TradeFeaturedModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(TradeFeaturedModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func bookmarkItem(userId: Int, itemId: Int, completion: SendRequestResult?) {
        post(at: .bookmarkItem(itemId: itemId)).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
        }
    }

    func contactOwner(userId: Int, itemId: Int, message: String, completion: SendRequestResult?) {
        let params = getContactOwnerParams(message)
        post(at: .contactOwner(itemId: itemId), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
        }
    }

}

extension AlamofireService {
    private func getItemParams(_ model: TradeFeaturedModel) -> Parameters {
        return Parameters()
    }

    private func getContactOwnerParams(_ message: String) -> Parameters {
        var params = Parameters()
        params["senderId"] = DataStore.shared.user?.id ?? -1
        params["time"] = DateManager.shared.getCurrentDate().timeIntervalSince1970
        return params
    }
}

//
//  AlamofireService+Trade.swift
//  
//
//  Created by KiKan Ng on 2/2/2019.
//

import Alamofire

extension AlamofireService: TradeService {

    func getTradeFeatured(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeFeatured).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getTradeSellingItems(completion: @escaping ([TradeSellingItemModel]?, Error?) -> Void) {
        get(at: .getTradeSellingItems).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeSellingItemModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeSellingItemModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getTradeSaved(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeSaved).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getTradeHistory(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeHistory).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getTradeList(filter: TradeFilterModel, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeList(filter: filter)).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func createTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        let params = getItemParams(model)
        post(at: .updatePreference, params: params).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
            // TODO: send image
        }
    }

    func editTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        // TODO
    }

    func getTradeItemData(itemId: Int, filter: ChartFilterOptions, completion: @escaping (ChartDataListModel?, Error?) -> Void) {
        // TODO
    }

    func getTradeDetail(itemId: Int, completion: @escaping (TradeFeaturedModel?, Error?) -> Void) {
        get(at: .getTradeDetail(itemId: itemId)).responseJSON { (res: DataResponse<Any>) in
            var result: TradeFeaturedModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(TradeFeaturedModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func bookmarkItem(itemId: Int, bookmarked: Bool, completion: SendRequestResult?) {
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        params["itemId"] = itemId
        params["bookmarked"] = bookmarked
        post(at: .bookmarkItem(itemId: itemId), params: params).responseJSON { (res: DataResponse<Any>) in
            var result: ServerMessage? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ServerMessage.self, from: data) }
            completion?(result?.message, res.result.error)
        }
    }

    func contactOwner(itemId: Int, message: String, completion: SendRequestResult?) {
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
        var params = Parameters()
        params["userId"] = DataStore.shared.user?.id
        params["name"] = model.title
        params["price"] = model.price
        params["description"] = model.detail
        // TODO
        params["quantity"] = 1
        params["trade_category_id"] = 1
        params["trade_condition_type_id"] = 1
        return Parameters()
    }

    private func getContactOwnerParams(_ message: String) -> Parameters {
        var params = Parameters()
        params["senderId"] = DataStore.shared.user?.id ?? -1
        params["time"] = DateManager.shared.getCurrentDate().timeIntervalSince1970
        return params
    }
}

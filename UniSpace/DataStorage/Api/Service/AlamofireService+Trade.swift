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
            result?.sort(by: { $0.id < $1.id })
            completion(result, res.result.error)
        }
    }

    func getTradeSellingItems(completion: @escaping ([TradeSellingItemModel]?, Error?) -> Void) {
        get(at: .getTradeSellingItems).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeSellingItemModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeSellingItemModel].self, from: data) }
            result?.sort(by: { $0.id < $1.id })
            completion(result, res.result.error)
        }
    }

    func getTradeSaved(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeSaved).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            result?.sort(by: { $0.id < $1.id })
            completion(result, res.result.error)
        }
    }

    func getTradeHistory(completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeHistory).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            result?.sort(by: { $0.id < $1.id })
            completion(result, res.result.error)
        }
    }

    func getTradeList(filter: TradeFilterModel, completion: @escaping ([TradeFeaturedModel]?, Error?) -> Void) {
        get(at: .getTradeList(filter: filter)).responseJSON { (res: DataResponse<Any>) in
            var result: [TradeFeaturedModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([TradeFeaturedModel].self, from: data) }
            result?.sort(by: { $0.id < $1.id })
            completion(result, res.result.error)
        }
    }

    func createTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        let params = getItemParams(model)
        post(at: .createTradeItem, params: params).responseJSON { (res: DataResponse<Any>) in
            var result: Int? = nil
            if let data = res.result.value { result = self.transform(from: data, type: Int.self) }
            guard let itemId = result else {
                completion?(nil, ServerError.UnknownClassType(object: "Team ID"))
                return
            }
            self.createTradeItemImage(itemId: itemId, images: images, completion: completion)
        }
    }

    private func createTradeItemImage(itemId: Int, images: [UIImage], completion: SendRequestResult?) {
        easyUpload(
            at: .createTradeItemImage(itemId: itemId),
            dataFormation: { (multipartFormData) in
                for (index, image) in images.enumerated() {
                    guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                        completion?(nil, ServerError.ImageFormatError(format: "jpeg"))
                        return
                    }
                    multipartFormData.append(imageData, withName: "photo[\(index)]", fileName: "photoURL.jpeg", mimeType: "image/jpeg")
                }
                multipartFormData.append("\(itemId)".data(using: .utf8)!, withName: "tradeId")
        }) { (res: DataResponse<Any>) in
            self.sendRequestStandardHandling(res: res, followUpAction: nil, completion: completion)
        }
    }

    func editTradeItem(model: TradeFeaturedModel, images: [UIImage], completion: SendRequestResult?) {
        let params = getItemParams(model)
        post(at: .editTradeItem(itemId: model.id), params: params).responseJSON { (res: DataResponse<Any>) in
            self.sendRequestStandardHandling(res: res, followUpAction: {
                self.createTradeItemImage(itemId: model.id, images: images, completion: completion)
            }, completion: completion)
        }
    }

    func getTradeItemData(itemId: Int, filter: ChartFilterOptions, completion: @escaping (ChartDataListModel?, Error?) -> Void) {
        get(at: .getTradeItemData(itemId: itemId, filter: filter)).responseJSON { (res: DataResponse<Any>) in
            var result: ChartDataListModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(ChartDataListModel.self, from: data) }
            completion(result, res.result.error)
        }
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
        params["tradeId"] = itemId
        params["bookmarked"] = bookmarked
        post(at: .bookmarkItem(itemId: itemId), params: params).responseJSON { (res: DataResponse<Any>) in
            self.sendRequestStandardHandling(res: res, followUpAction: nil, completion: completion)
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
        params["quantity"] = model.quantity
        params["trade_category_id"] = model.tradeCategory.pathExtension
        params["trade_condition_type_id"] = model.tradeItemCondition.pathExtension
        params["district_id"] = model.location
        return params
    }
}

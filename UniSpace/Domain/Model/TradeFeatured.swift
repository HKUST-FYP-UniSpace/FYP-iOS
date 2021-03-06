//
//  TradeFeatured.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol TradeFeatured: HavePhotos {

    var id: Int { get set }
    var title: String { get set }
    var location: String { get set }
    var transactionType: String { get set }
    var price: Int { get set }
    var status: String { get set }
    var detail: String { get set }
    var isBookmarked: Bool { get set }
    var photoURLs: [String] { get set }

    var quantity: Int { get set }
    var tradeCategory: TradeCategory { get set }
    var tradeItemCondition: TradeItemCondition { get set }

}

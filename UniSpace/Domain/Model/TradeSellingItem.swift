//
//  TradeSellingItem.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol TradeSellingItem: HavePhoto {

    var id: Int { get set }
    var title: String { get set }
    var price: Int { get set }
    var views: Int { get set }
    var photoURL: String { get set }

}

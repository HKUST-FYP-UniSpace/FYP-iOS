//
//  TradeFeatured.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol TradeFeatured: PhotoShowable {

    var id: Int { get set }
    var title: String { get set }
    var location: String { get set }
    var price: Int { get set }
    var status: String { get set }
    var detail: String { get set }
    var photoURL: String { get set }

}

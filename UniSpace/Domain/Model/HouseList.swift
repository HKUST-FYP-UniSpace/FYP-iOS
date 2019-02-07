//
//  HouseList.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseList: PhotoShowable {

    var id: Int { get set }
    var title: String { get set }
    var price: Int { get set }
    var size: Int { get set }
    var starRating: Int { get set }
    var subtitle: String { get set }
    var photoURL: String { get set }

}

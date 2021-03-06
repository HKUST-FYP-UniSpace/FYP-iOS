//
//  HouseList.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseList: HavePhotos {

    var id: Int { get set }
    var title: String { get set }
    var price: Int { get set }
    var size: Int { get set }
    var starRating: Double { get set }
    var subtitle: String { get set }
    var address: String { get set }
    var isBookmarked: Bool { get set }
    var photoURLs: [String] { get set }
    var rooms: Int { get set }
    var beds: Int { get set }
    var toilets: Int { get set }
    var district_id: String { get set }

}

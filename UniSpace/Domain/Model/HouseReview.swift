//
//  HouseReview.swift
//  UniSpace
//
//  Created by KiKan Ng on 7/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseReview: HavePhoto {

    var id: Int { get set }
    var username: String { get set }
    var title: String { get set }
    var date: Double { get set }
    var detail: String { get set }
    var starRating: Double { get set }

    var ownerId: Int { get set }
    var ownerComment: String { get set }
    var photoURL: String { get set }

}

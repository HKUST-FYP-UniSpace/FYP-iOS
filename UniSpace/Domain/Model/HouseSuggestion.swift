//
//  HouseSuggestion.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseSuggestion: PhotoShowable {

    var houseId: Int { get set }
    var teamId: Int { get set }
    var title: String { get set }
    var preference: PreferenceModel { get set }
    var groupSize: Int { get set }
    var occupiedCount: Int { get set }
    var photoURL: String { get set }
    var duration: String { get set }

}

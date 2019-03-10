//
//  HouseTeamSummary.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseTeamSummary: HavePhoto {

    var id: Int { get set }
    var title: String { get set }
    var price: Int { get set }
    var duration: String { get set }
    var preference: PreferenceModel { get set }
    var description: String { get set }
    var groupSize: Int { get set }
    var occupiedCount: Int { get set }
    var photoURL: String { get set }

}

//
//  HouseSuggestion.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseSuggestion: PhotoShowable {

    var id: Int { get set }
    var title: String { get set }
    var subtitle: String { get set }
    var photoURL: String { get set }
    var duration: String { get set }

}

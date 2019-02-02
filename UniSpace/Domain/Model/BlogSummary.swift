//
//  BlogSummary.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol BlogSummary {

    var id: Int { get set }
    var title: String { get set }
    var subTitle: String { get set }
    var photoURL: String { get set }

}

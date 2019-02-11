//
//  BlogSummary.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol BlogSummary: PhotoShowable {

    var id: Int { get set }
    var title: String { get set }
    var subtitle: String { get set }
    var detail: String { get set }
    var time: Double { get set }
    var photoURL: String { get set }

}

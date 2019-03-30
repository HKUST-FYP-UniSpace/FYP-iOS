//
//  ChartData.swift
//  UniSpace
//
//  Created by KiKan Ng on 30/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol ChartData {

    var order: Int { get set }
    var time: Double { get set }
    var x: Double { get set }
    var y: Double { get set }

}

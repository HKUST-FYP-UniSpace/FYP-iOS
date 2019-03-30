//
//  ChartDataModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 30/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class ChartDataModel: Decodable, Equatable, ChartData {

    var order: Int = 0
    var time: Double = 0
    var x: Double = 0
    var y: Double = 0

    init() {}

    static func == (lhs: ChartDataModel, rhs: ChartDataModel) -> Bool {
        return lhs.order == rhs.order
    }

}

class ChartsDataModel: Decodable {

    var targetPerformance: [ChartDataModel] = []
    var othersPerformance: [ChartDataModel] = []

    init() {}

}

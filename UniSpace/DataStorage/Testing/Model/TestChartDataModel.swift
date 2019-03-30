//
//  TestChartDataModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 30/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestChartDataModel: ChartData {

    var order: Int
    var time: Double
    var x: Double
    var y: Double

    required init() {
        order = 0
        time = DateManager.shared.randomTime(30)
        x = 0
        y = Double(Int.random(in: 0...100))
    }

    func setup(order: Int) {
        self.order = order
        self.x = Double(order)
    }

    func reRandomize() {
        y = Double(Int.random(in: 0...100))
    }

    func toModel() -> ChartDataModel {
        let model = ChartDataModel()
        model.order = order
        model.time = time
        model.x = x
        model.y = y
        return model
    }
}

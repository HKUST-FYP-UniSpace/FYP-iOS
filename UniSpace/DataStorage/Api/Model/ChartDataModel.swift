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

    enum CodingKeys: String, CodingKey {
        case order
        case time
        case x
        case y
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &order, type: Int.self, forKey: .order)
        decode(container, &time, type: Double.self, forKey: .time)
        decode(container, &x, type: Double.self, forKey: .x)
        decode(container, &y, type: Double.self, forKey: .y)
    }

    private func decode<T>(_ container: KeyedDecodingContainer<CodingKeys>, _ variable: inout T, type: T.Type, forKey key: CodingKeys) where T: Decodable {
        if let _variable = try? container.decode(type, forKey: key) {
            variable = _variable
        }
    }

    init() {}

    static func == (lhs: ChartDataModel, rhs: ChartDataModel) -> Bool {
        return lhs.order == rhs.order
    }

}

class ChartDataListModel: Decodable {

    var targetViews: [ChartDataModel] = []
    var othersViews: [ChartDataModel] = []
    var targetBookmarks: [ChartDataModel] = []
    var othersBookmarks: [ChartDataModel] = []

    init() {}

}

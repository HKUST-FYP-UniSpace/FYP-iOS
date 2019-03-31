//
//  CalendarDataModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 31/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class CalendarDataModel: Decodable, CalendarData {

    var startTime: String = ""
    var endTime: String = ""
    var appointment: String = ""

    init() {}

}


class CalendarDataListModel: Decodable {

    var date: Int = 0
    var data: [CalendarDataModel] = []

    init() {}

}

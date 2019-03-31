//
//  TestCalendarDataModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 31/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestCalendarDataModel: CalendarData {

    var startTime: String
    var endTime: String
    var appointment: String

    required init() {
        startTime = "16:00"
        endTime = "17:30"
        appointment = Lorem.sentence()
    }

    func toModel() -> CalendarDataModel {
        let model = CalendarDataModel()
        model.startTime = startTime
        model.endTime = endTime
        model.appointment = appointment
        return model
    }
}

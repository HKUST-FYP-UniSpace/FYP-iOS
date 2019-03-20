//
//  DateManager.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation
class DateManager: NSObject {
    
    public static let shared:DateManager = DateManager()
    
    private let secondsInADay = 86400
    
    private let timeFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }

    private let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    private override init() {
        super.init()
    }

    func convertToTimeFormat(date: Date) -> String {
        return timeFormatter().string(from: date)
    }

    func convertToDateFormat(date: Date) -> String {
        return dateFormatter().string(from: date)
    }

    func daysBeforeNow(_ before: Date) -> Int {
        let today = getCurrentDate()
        let d = DateInterval(start: before, end: today)
        return Int(d.duration / Double(secondsInADay))
    }

    func getCurrentDate() -> Date {
        return getDateAfterDays(days: 0)
    }
    
    func getDateAfterDays(days: Int) -> Date {
        return Date(timeInterval: TimeInterval(days * secondsInADay), since: Date())
    }

    func randomTime(_ withinDays: Int) -> Double {
        let seconds = secondsInADay * withinDays
        let date = Date(timeInterval: TimeInterval(-Int.random(in: 0...seconds)), since: Date())
        return date.timeIntervalSince1970
    }

    func isToday(_ date: Date) -> Bool {
        return NSCalendar.current.isDateInToday(date)
    }

    func numberOfDays(year: Int, month: Int) -> Int? {
        guard year > 0 && month > 0 && month <= 12 else { return nil }
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
}

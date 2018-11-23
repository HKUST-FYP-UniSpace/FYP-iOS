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
    
    private let dateAndTimeFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    private let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    private let beautyDateAndTimeFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "HH:mm dd-MMM-yyyy"
        return formatter
    }
    
    private let beautyDateAndTimeFormatterWithDOW = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "HH:mm dd-MMM-yyyy (EEE)"
        return formatter
    }
    
    private let beautyDateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }
    
    private let beautyDateFormatterWithDOW = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "dd-MMM-yyyy (EEE)"
        return formatter
    }
    
    private override init() {
        super.init()
    }
    
    func getCurrentDate() -> String {
        return getDateAfterDays(days: 0)
    }
    
    func getCurrentDateAndTime() -> String {
        return getDateAfterDays(days: 0, includeSecs: true)
    }
    
    func getDateAfterDays(days: Int, includeSecs: Bool = false) -> String {
        let date = Date(timeInterval: TimeInterval(days * secondsInADay), since: Date())
        return includeSecs ? dateAndTimeFormatter().string(from: date) : dateFormatter().string(from: date)
    }
    
    func convertToUnixTime(date: String) -> TimeInterval? {
        if let unixTime: Date = dateFormatter().date(from: date) {
            return unixTime.timeIntervalSince1970
        }
        if let unixTime: Date = dateAndTimeFormatter().date(from: date) {
            return unixTime.timeIntervalSince1970
        }
        return nil
    }
    
    func convertToUserFriendlyFormat(date: String, withDayOfWeek: Bool) -> String? {
        if let unixTime: Date = dateAndTimeFormatter().date(from: date) {
            return withDayOfWeek ? beautyDateAndTimeFormatterWithDOW().string(from: unixTime) : beautyDateAndTimeFormatter().string(from: unixTime)
        }
        if let unixTime: Date = dateFormatter().date(from: date) {
            return withDayOfWeek ? beautyDateFormatterWithDOW().string(from: unixTime) : beautyDateFormatter().string(from: unixTime)
        }
        return nil
    }
    
}

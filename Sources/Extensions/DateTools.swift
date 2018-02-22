//
//  DateTools.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 3/1/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation

fileprivate var dateFormatterLocale: Locale?

public extension DateFormatter {
    
    public static func setLocale(_ locale: Locale) { dateFormatterLocale = locale }

    public convenience init(_ format: String) {
        self.init()
        self.dateFormat = format
        if let locale = dateFormatterLocale { self.locale = locale }
    }
}

public extension Date {
    
    //MARK: - Elements
    
    var second:        Int { return Calendar.current.component(.second,  from: self) }
    var minute:        Int { return Calendar.current.component(.minute,  from: self) }
    var hour:          Int { return Calendar.current.component(.hour,    from: self) }
    var day:           Int { return Calendar.current.component(.day,     from: self) }
    var month:         Int { return Calendar.current.component(.month,   from: self) }
    var year:          Int { return Calendar.current.component(.year,    from: self) }
    var weekdayNumber: Int { return Calendar.current.component(.weekday, from: self) }
    
    var isWeekend: Bool {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        return calendar.isDateInWeekend(self)
    }

    //MARK: - Initializatiors
    
    public static func with(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    public static func todayWith(hour: Int, minute: Int, second: Int) -> Date {
        let current = Date()
        var dateComponents = DateComponents()
        dateComponents.year = current.year
        dateComponents.month = current.month
        dateComponents.day = current.day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        return NSCalendar(calendarIdentifier: .gregorian)!.date(from: dateComponents)!
    }
    
    public static func parse(_ dateString: String, format: String) -> Date? {
        return DateFormatter(format).date(from: dateString)
    }
    
    public func stringWithFormat(_ format: String) -> String {
        return DateFormatter(format).string(from: self)
    }
    
    private static let cal = Calendar(identifier: .gregorian)
    
    public func isEqualDayTo(_ date: Date) -> Bool {
        return self.withoutTimeComponent == date.withoutTimeComponent
    }
    
    public var withoutTimeComponent: Date {
        return Date.cal.date(bySetting: .minute, value: 0, of:
               Date.cal.date(bySetting: .hour, value: 0, of: self)!)!
    }
}

public extension Int {
    
    public var hoursMinuteString: String {
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(self))
        return date.stringWithFormat("HH:mm")
    }
    
    public var timeComponentString: String {
        if self > 9 { return "\(self)" }
        else { return "0\(self)" }
    }
}

public extension TimeInterval {
    public var timeString: String {
        var totalSeconds: Int = abs(self.Int)
        let hours: Int = totalSeconds / (60 * 60)
        totalSeconds -= hours * 60 * 60
        let minutes = totalSeconds / 60
        totalSeconds -= minutes * 60
        return "\(hours.timeComponentString):\(minutes.timeComponentString):\(totalSeconds.timeComponentString)"
    }
}

public func -(left: Date, right: Date) -> Date {
    return Date(timeIntervalSinceReferenceDate: left.timeIntervalSinceReferenceDate - right.timeIntervalSinceReferenceDate)
}

public func -= ( left: inout Date, right: Date) {
    left = Date(timeIntervalSinceReferenceDate: left.timeIntervalSinceReferenceDate - right.timeIntervalSinceReferenceDate)
}

//
//  DateTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 3/1/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation
import AVFoundation

fileprivate let dateTimeFormatter    = DateFormatter("HH:mm dd-MM-yyyy")
fileprivate let dateFormatter        = DateFormatter("dd-MM-yyyy")
fileprivate let hourMinTimeFormatter = DateFormatter("HH:mm")
fileprivate let minSecTimeFormatter  = DateFormatter("mm:ss")
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
    
    var day:   Int { return Calendar.current.component(.day,   from: self) }
    var month: Int { return Calendar.current.component(.month, from: self) }
    var year:  Int { return Calendar.current.component(.year,  from: self) }
    
    var monthString: String { return DateFormatter("MMMM").string(from: self) }
    
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
    
    public static func parse(_ dateString: String, format: String? = nil) -> Date {
        
        if let format = format {
            let formatter = DateFormatter(format)
            if let date = formatter.date(from: dateString) { return date }
            else { Log.error(); return Date() }
        }
        
        if let date = dateTimeFormatter.date(from: dateString) { return date }
        else { Log.error(); return Date() }
    }
    
    public func stringWithFormat(_ format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    private static let cal = Calendar(identifier: .gregorian)
    
    public var withoutTimeComponent: Date {
        
        return Date.cal.date(bySetting: .minute, value: 0, of: Date.cal.date(bySetting: .hour, value: 0, of: self)!)!
    }
    
    public var timeString: String {
        
        return hourMinTimeFormatter.string(from: self)
    }
    
    public var dateString: String {
        
        return dateFormatter.string(from: self)
    }
    
    public static var currentDateTimeString: String {
        
        return dateTimeFormatter.string(from: Date())
    }
    
    public static var currentDateString: String {
        
        return dateFormatter.string(from: Date())
    }
}

public extension Int {
    
    public var hoursMinuteString: String {
        
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(self))
        return minSecTimeFormatter.string(from: date)
    }
}

public extension CMTime {
    
    public var String: String {
        
        let date = Date(timeIntervalSinceReferenceDate: CMTimeGetSeconds(self))
        return hourMinTimeFormatter.string(from: date)
    }
    
}

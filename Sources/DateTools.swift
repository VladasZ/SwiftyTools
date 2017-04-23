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

public extension DateFormatter {
    
    convenience init(_ format: String) {
        
        self.init()
        self.dateFormat = format
    }
}

public extension Date {
    
    static func parse(_ dateString: String) -> Date {
        
        if let date = dateTimeFormatter.date(from: dateString) {
            
            return date
        }
        
        Log.error()
        return Date()
    }
    
    func stringWithFormat(_ format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    private static let cal = Calendar(identifier: .gregorian)
    
    var withoutTimeComponent: Date {
        
        return Date.cal.date(bySetting: .minute, value: 0, of: Date.cal.date(bySetting: .hour, value: 0, of: self)!)!
    }
    
    var timeString: String {
        
        return hourMinTimeFormatter.string(from: self)
    }
    
    var dateString: String {
        
        return dateFormatter.string(from: self)
    }
    
    static var currentDateTimeString: String {
        
        return dateTimeFormatter.string(from: Date())
    }
    
    static var currentDateString: String {
        
        return dateFormatter.string(from: Date())
    }
}

public extension Int {
    
    var hoursMinuteString: String {
        
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(self))
        return minSecTimeFormatter.string(from: date)
    }
}

public extension CMTime {
    
    var String: String {
        
        let date = Date(timeIntervalSinceReferenceDate: CMTimeGetSeconds(self))
        return hourMinTimeFormatter.string(from: date)
    }
    
}

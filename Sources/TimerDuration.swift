//
//  TimerDuration.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 3/2/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation

fileprivate let secondsInHour   = 60 * 60
fileprivate let secondsInMinute = 60

public class TimerDuration {
    
    public var startDate: Date?
    
    private var startInterval: TimeInterval = 0
    private var pauseInterval: TimeInterval = 0
    private var stopDate:  TimeInterval = 0
    
    public var totalSeconds: TimeInterval {
        get {
            if startDate == nil { return 0 }
            if pauseInterval == 0 && stopDate == 0 {
                return Date().timeIntervalSinceReferenceDate - startInterval
            }
            else if stopDate == 0 {
                return pauseInterval - startInterval
            }
            else {
                return stopDate - startInterval
            }
        }
        set {
            startInterval = 0
            stopDate = newValue
        }
    }
    
    public var seconds: Int {
        var seconds = Int(self.totalSeconds)
        seconds %= secondsInHour
        seconds %= secondsInMinute
        return seconds
    }
    
    public var minutes: Int {
        var seconds = Int(self.totalSeconds)
        seconds %= secondsInHour
        return seconds / secondsInMinute
    }
    
    public var hours: Int {
        return Int(self.totalSeconds) / secondsInHour
    }
    
    public init() { }
    
    public var isPaused: Bool = false {
        didSet {
            if isPaused {
                pauseInterval = Date().timeIntervalSinceReferenceDate
            }
            else {
                guard pauseInterval != 0 else { return }
                startInterval += Date.timeIntervalSinceReferenceDate - pauseInterval
                pauseInterval = 0
            }
        }
    }
    
    public var stopped: Bool { return stopDate != 0 }
    
    //MARK: - Interface
    
    public func start() {
        if startDate != nil { LogError(); return }
        startDate = Date()
        startInterval = Date().timeIntervalSinceReferenceDate
    }

    public func stop() {
        isPaused = false
        stopDate = Date().timeIntervalSinceReferenceDate
    }
    
    public var toString: String {

        var seconds = Int(self.totalSeconds)
        
        let hours = seconds / secondsInHour
        seconds %= secondsInHour
        let minutes = seconds / secondsInMinute
        seconds %= secondsInMinute
        
        return "\(timeComponentToString(hours)):\(timeComponentToString(minutes)):\(timeComponentToString(seconds))"
    }
    
    public var description: String {
        
        var seconds = Int(self.totalSeconds)
        
        seconds %= secondsInHour
        let minutes = seconds / secondsInMinute
        seconds %= secondsInMinute
        
        return "\(timeComponentToString(minutes)):\(timeComponentToString(seconds))"
    }
    
    public func timeComponentToString(_ component: Int) -> String {
        
        if component < 10 { return "0\(component)"}
        return  "\(component)"
    }
}

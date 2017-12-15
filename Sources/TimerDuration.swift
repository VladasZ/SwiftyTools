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
    
    private var startDate: TimeInterval = 0
    private var pauseDate: TimeInterval = 0
    private var stopDate:  TimeInterval = 0
    
    public var totalSeconds: TimeInterval {
        get {
            if pauseDate == 0 && stopDate == 0 {
                return Date().timeIntervalSinceReferenceDate - startDate
            }
            else if stopDate == 0 {
                return pauseDate - startDate
            }
            else {
                return stopDate - startDate
            }
        }
        set {
            startDate = 0
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
                
                pauseDate = Date().timeIntervalSinceReferenceDate
            }
            else {
                
                guard pauseDate != 0 else { return }
                
                startDate += Date.timeIntervalSinceReferenceDate - pauseDate
                pauseDate = 0
            }
        }
    }
    
    public var stopped: Bool { return stopDate != 0 }
    
    //MARK: - Interface
    
    public func start() {
        
        startDate = Date().timeIntervalSinceReferenceDate
    }

    public func stop() {
        
        isPaused = false
        stopDate = Date().timeIntervalSinceReferenceDate
    }
    
    public var String: String {
        
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
    
    private func timeComponentToString(_ component: Int) -> String {
        
        if component < 10 { return "0\(component)"}
        return  "\(component)"
    }
}

//
//  TimersKit.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/23/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public typealias TimerAction = (inout Bool) -> ()

public extension Timer {
    
    @discardableResult static func every(_ interval: Double, _ action: @escaping TimerAction) -> Timer {
        
        let timer = Timer.scheduledTimer(timeInterval: interval,
                                         target: self,
                                         selector: #selector(self.timerAction(_:)),
                                         userInfo: action,
                                         repeats: true)
        timer.fire()
        return timer
    }
    
    @objc private static func timerAction(_ timer: Timer) {
 
        guard let action = timer.userInfo as? TimerAction else { Log.error(); timer.invalidate(); return }
        
        var stop: Bool = false
        action(&stop)
        if stop { timer.invalidate() }
    }
}

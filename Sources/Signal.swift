//
//  Signal.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 4/27/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

fileprivate struct SignalSubscriber {
    
    var file: String
    var action: () -> ()
}

public class Signal {
    
    private var subscribers = [SignalSubscriber]()
    
    public init () { }
    
    public func subscribe(_ file: String = #file, _ action: @escaping () -> ()) {
        
        unsubscribe(file)
        subscribers.append(SignalSubscriber(file: file, action: action))
    }
    
    public func unsubscribe(_ file: String = #file) {
        
        subscribers = subscribers.filter { $0.file != file }
    }
    
    public func fire() {
        
        DispatchQueue.main.async { self.subscribers.forEach { $0.action() } }
    }
}

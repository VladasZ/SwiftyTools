//
//  Signal.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 4/27/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

fileprivate struct SignalSubscriber : Hashable {

    static func ==(lhs: SignalSubscriber, rhs: SignalSubscriber) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    var hashValue: Int { return file.hashValue + line.hashValue }
    
    var identifier: String { return file + String(line) }
    
    var file: String
    var line: Int
    var action: () -> ()
}

public class Signal {
    
    private var subscribers = [String : SignalSubscriber]()
    private var linked: Signal?
    private var _action: (() -> ())?
    private var _identifier: String?
    
    public init(_ id: String? = nil, linked: Signal? = nil, _ action: (() -> ())? = nil) {
        
        self._identifier = id
        self.linked = linked
        self._action = action
    }
    
    public func subscribe(_ file: String = #file, _ line: Int = #line, _ action: @escaping () -> ()) {
        
        let subscriber = SignalSubscriber(file: file, line: line, action: action)
        subscribers[subscriber.identifier] = subscriber
    }
    
    public func unsubscribeFile(_ file: String = #file) {
        
        let filterredArray = subscribers.filter { $0.value.file != file }
        subscribers.removeAll()
        filterredArray.forEach { subscribers[$0.key] = $0.value }
    }
    
    public func fire() {
        
        if let id = _identifier { Log.info("Signal: " + id + " triggered") }
        
        DispatchQueue.main.async {
            
            self._action?()
            if let linked = self.linked { for (_, element) in linked.subscribers { element.action() } }
            for (_, element) in self.subscribers { element.action() }
        }
    }
}

//
//  Signal.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 4/27/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

fileprivate struct SignalSubscriber<T> : Hashable {
    
    static func ==(lhs: SignalSubscriber, rhs: SignalSubscriber) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(file)
        hasher.combine(line)
    }
    
    var identifier: String {
        
        var id = file + String(line)
        if let hash = linkedObject?.hash {
            id.append(String(hash))
        }
        
        return id
    }
    
    var file: String
    var line: Int
    var action: (T) -> ()
    weak var linkedObject: AnyObject?
    
    
    init(file: String, line: Int, action: @escaping (T) -> ()) {
        self.file = file
        self.line = line
        self.action = action
    }
}

public class Signal<T> {
    
    private var subscribers = [String : SignalSubscriber<T>]()
    private var linked: Signal?
    private var _action: ((T) -> ())?
    private var _identifier: String?
    private var _logEnabled = true
    
    public init(_ id: String? = nil, linked: Signal? = nil, _ action: ((T) -> ())? = nil) {
        
        self._identifier = id
        self.linked = linked
        self._action = action
    }
    
    public func subscribe(_ file: String = #file, _ line: Int = #line, _ action: @escaping (T) -> ()) {
        
        let subscriber = SignalSubscriber(file: file, line: line, action: action)
        subscribers[subscriber.identifier] = subscriber
    }
    
    public func subscribe(_ file: String = #file, _ line: Int = #line, object: AnyObject, _ action: @escaping (T) -> ()) {
        
        var subscriber = SignalSubscriber(file: file, line: line, action: action)
        subscriber.linkedObject = object
        subscribers[subscriber.identifier] = subscriber
    }
    
    public func unsubscribeFile(_ file: String = #file) {
        
        let filterredArray = subscribers.filter { $0.value.file != file }
        subscribers.removeAll()
        filterredArray.forEach { subscribers[$0.key] = $0.value }
    }
    
    public func unsubscribeObject() {
        
        let filterredArray = subscribers.filter { $0.value.linkedObject != nil }
        subscribers.removeAll()
        filterredArray.forEach { subscribers[$0.key] = $0.value }
    }
    
    public func disableLog() -> Self {
        _logEnabled = false
        return self
    }
    
    public func fire(_ value: T) {
        
        if _logEnabled {
            if let id = _identifier { Log("Signal: " + id + " triggered") }
        }
        
        func _fire() {
            
            self._action?(value)
            if let linked = self.linked { linked.fire(value) }
            for (_, element) in self.subscribers { element.action(value) }
        }
        
        if Thread.isMainThread { _fire() }
        else { onMain { _fire() } }
    }
}


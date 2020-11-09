//
//  Misc.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation


func wait(_ delay: Double) {
    usleep(useconds_t(1000000 * delay))
}

func sync(_ action: @escaping () -> ()) {
    if Thread.isMainThread { action(); return }
    DispatchQueue.main.async(execute: action)
}

func async(_ action: @escaping () -> ()) {
    DispatchQueue.global().async(execute: action)
}

public func after(_ delay: Double, action: @escaping () -> ()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: action)
}

@inline(__always)
public func random() -> Int {
    Int(UInt32(arc4random()))
}

@inline(__always)
public func random(_ uniform:Int) -> Int {
    Int(UInt32(arc4random_uniform(UInt32(uniform))))
}

@inline(__always)
public func randomBool() -> Bool {
    UInt32(arc4random()) % UInt32(2) == 0
}

//https://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
public func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}

extension Array {
    
    func applyTask(_ task: (_ object: Element, _ completion: @escaping Completion) -> (), _ completion: @escaping Completion) {
        
        let group = DispatchGroup()
        
        var requestError: String?
        
        for object in self {
            group.enter()
            task(object) { error in
                if let error = error {
                    requestError = error
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(requestError)
        }
        
    }
    
}

class Weak<T: AnyObject & Hashable> : Hashable {
    
    weak var value: T?
    
    init() { }
    
    init(_ value: T) {
        self.value = value
    }
    
    func hash(into hasher: inout Hasher) {
        guard let value = value else { return }
        hasher.combine(value.hashValue)
    }
    
    static func == (lhs: Weak, rhs: Weak) -> Bool {
        lhs.value === rhs.value
    }
    
    static func == (lhs: Weak, rhs: T) -> Bool {
        lhs.value === rhs
    }
}

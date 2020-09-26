//
//  Misc.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

class Wait {
    
    private let _start: () -> ()
    private let _end:   () -> ()
    
    static func make(_ start: @escaping () -> (), end: @escaping () -> ()) -> Wait {
        return Wait(start, end: end)
    }
    
    init(_ start: @escaping () -> (), end: @escaping () -> ()) {
        _start = start
        _end   = end
    }
    
    func start() { sync { self._start() } }
    func end()   { sync { self._end()   } }
    
}

func wait(_ delay: Double) {
    usleep(useconds_t(1000000 * delay))
}

func sync(_ request: (@escaping Completion) -> ()) -> String? {
    var error: String?
    let group = DispatchGroup()
    group.enter()
    request { e in
        if let e = e { error = e }
        group.leave()
    }
    group.wait()
    return error
}

func sync(_ request: (@escaping Completion) -> (), fail: @escaping Fail) {
    request { e in
        sync { if let e = e { fail(e) } }
    }
}

func sync(_ wait: Wait, _ request: (@escaping Completion) -> (), fail: @escaping Fail) {
    wait.start()
    request { e in
        sync { if let e = e { fail(e) } }
        wait.end()
    }
}

func sync(_ request: (@escaping Completion) -> (), ok: @escaping Ok, fail: @escaping Fail) {
    request { e in
        sync { if let e = e { fail(e) } else { ok() } }
    }
}

func sync(_ wait: Wait, _ request: (@escaping Completion) -> (), ok: @escaping Ok, fail: @escaping Fail) {
    wait.start()
    request { e in
        sync { if let e = e { fail(e) } else { ok() } }
        wait.end()
    }
}

func sync(_ action: @escaping () -> ()) {
    if Thread.isMainThread { action(); return }
    DispatchQueue.main.async(execute: action)
}

func async(_ action: @escaping () -> ()) {
    DispatchQueue.global().async(execute: action)
}

func async(_ wait: Wait, _ action: @escaping () -> ()) {
    wait.start()
    DispatchQueue.global().async {
        action()
        wait.end()
    }
}

public func after(_ delay: Double, action: @escaping () -> ()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: action)
}

@inline(__always)
public func random() -> Int {
    return Int(UInt32(arc4random()))
}

@inline(__always)
public func random(_ uniform:Int) -> Int {
    return Int(UInt32(arc4random_uniform(UInt32(uniform))))
}

@inline(__always)
public func randomBool() -> Bool {
    return UInt32(arc4random()) % UInt32(2) == 0
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

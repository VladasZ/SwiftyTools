//
//  Number.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 11/1/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

extension String : Error { }

public class Number {
    
    public var value: String
    
    public func getValue<T>() -> T {
        switch T.self {
        case is String.Type: return value as! T
        case is Int.Type: return Int(value.withoutFractionPart) as! T
        case is Float.Type: return Float(value) as! T
        case is Double.Type: return Double(value) as! T
        default: return "Error" as! T
        }
    }
    
    public init(_ value: Any?) throws { guard let value = value else { throw "Failed Number" }
        switch value {
        case is String: self.value =        value as! String
        case is Int:    self.value = String(value as! Int)
        case is Float:  self.value = String(value as! Float)
        case is Double: self.value = String(value as! Double)
        default: throw "Failed Number"
        }
    }
}

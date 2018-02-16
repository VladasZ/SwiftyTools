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
        case is Bool.Type: return (value != "0") as! T
        case is String.Type: return value as! T
        case is Int.Type: return Int(value.withoutFractionPart) as! T
        case is Float.Type: return Float(value) as! T
        case is Double.Type: return Double(value) as! T
        default: return "Error" as! T
        }
    }
    
    public init?(_ value: Any?) { guard let value = value else { return nil }
        switch value {
        case is String: let string = value as! String
        if string == "true" || string == "false" {
            self.value = string == "true" ? "1" : "0"
        }
        else {
            guard Double(string) != nil else { return nil }
            self.value = string
        }
        case is Int:    self.value = String(value as! Int)
        case is Float:  self.value = String(value as! Float)
        case is Double: self.value = String(value as! Double)
        case is Bool:   self.value = (value as! Bool) ? "1" : "0"
        default: return nil
        }
    }
}


//
//  Optional.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 8/17/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation


@discardableResult public func optionalCheck<T>(_ value: T?,
                                             default: T,
                                             _ file:String = #file,
                                             _ function:String = #function,
                                             _ line:Int = #line) -> T {
    
    if let value = value { return value }
    Log.error("Optional check", file, function, line)
    return `default`
}

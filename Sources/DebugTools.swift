//
//  Debug.swift
//  TransFix
//
//  Created by Vladas Zakrevskis on 3/29/17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import Foundation

public class Debug {
    
    public static func check(_ object: Any?, error: String) {
        
        #if DEBUG
            if object == nil { Alert.debugError(error) }
        #endif
    }
    
    public static func checkForNil(_ object: Any?, error: String) {
        
        #if DEBUG
            if object != nil { Alert.debugError(error) }
        #endif
    }
    
    public static func execute(_ block: () -> ()) {
        
        #if DEBUG
            block()
        #endif
    }
    
    public static func executeOnSimulator(_ simulator: () -> (), device: () -> ()) {
        
        #if DEBUG
            
            #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
                simulator()
            #else
                device()
            #endif
            
        #endif
    }
    
    public static func addressOf<T: AnyObject>(_ object: T) -> Int {
        
        return unsafeBitCast(object, to: Int.self)
    }

}

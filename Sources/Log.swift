//
//  Log.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 3/2/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation

fileprivate enum LogType {
    
    case info
    case warning
    case error
}

fileprivate let noMessageString = "noMessageString"

public class Log {
    
    public static func info(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
        
        log(message, withType: .info, file, function, line)
    }
    
    public static func warning(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
        
        log(message, withType: .warning, file, function, line)
    }
    
    public static func error(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
        
        log(message, withType: .error, file, function, line)
    }
    
    private static func log(_ message: Any?, withType type:LogType, _ file:String, _ function:String, _ line:Int) {
        
        var typeString: String
        let file = file.lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        
        switch type {
        case .info:    typeString = "💚 INFO 💚"
        case .warning: typeString = "💛 WARNING 💛"
        case .error:   typeString = "❤️ ERROR ❤️"
        }
        
        var logMessage = "[\(typeString)]"
        
        logMessage.append("[\(file)::\(function) - \(line)]")
        
        if message as? String != noMessageString {
         
            if let message = message { logMessage.append(" " + String(describing: message)) }
            else                     { logMessage.append(" nil") }
        }
        
        
        print(logMessage)
    }
}

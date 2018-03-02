//
//  Log.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 3/2/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation

public let noMessageString = "noMessageString"

public class Log {
    
    public static var infoSymbol = "💚"
    public static var warningSymbol = "💛"
    public static var errorSymbol = "❤️"
    
    public static var enabled = true

    public static func info(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
        log(message, withType: .info, file, function, line)
    }
    
    public static func warning(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
        log(message, withType: .warning, file, function, line)
    }
    
    public static func error(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
        log(message, withType: .error, file, function, line)
    }
    
    private static func log(_ message: Any?, withType type: LogType, _ file:String, _ function:String, _ line:Int) {
        
        if !enabled { return }
        
        var typeString: String
        let file = file.lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        
        switch type {
        case .info:    typeString = "\(infoSymbol) INFO \(infoSymbol)"
        case .warning: typeString = "\(warningSymbol) WARNING \(warningSymbol)"
        case .error:   typeString = "\(errorSymbol) ERROR \(errorSymbol)"
        }
        
        var logMessage = "[\(typeString)]"
        
        logMessage.append("[\(file)::\(function) - \(line)]")
        
        if message as? String != noMessageString {
            if let message = message { logMessage.append(" " + String(describing: message)) }
            else                     { logMessage.append(" nil") }
        }
        
        if saveMessages {
            messages.append(LogMessage(type: type,
                                       location: "\(file)::\(function) - \(line)",
                                       message: String(describing: message)))
        }
        
        
        print(logMessage)
    }
}

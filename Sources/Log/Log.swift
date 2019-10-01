//
//  Log.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 3/2/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation

public let noMessageString = "noMessageString"

public class LogSetup {
    public static var infoSymbol = "💚"
    public static var warningSymbol = "💛"
    public static var errorSymbol = "❤️"
    
    public static var enabled = true
}

fileprivate class _Log {
    
    fileprivate static func log(_ message: Any?, withType type: LogType, _ file:String, _ function:String, _ line:Int) {
        
        if !LogSetup.enabled { return }
        
        var typeString: String
        let file = file.lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        
        switch type {
        case .info:    typeString = "\(LogSetup.infoSymbol) INFO \(LogSetup.infoSymbol)"
        case .warning: typeString = "\(LogSetup.warningSymbol) WARNING \(LogSetup.warningSymbol)"
        case .error:   typeString = "\(LogSetup.errorSymbol) ERROR \(LogSetup.errorSymbol)"
        }
        
        var logMessage = "[\(typeString)]"
        
        logMessage.append("[\(file)::\(function) - \(line)]")
        
        if message as? String != noMessageString {
            if let message = message { logMessage.append(" " + String(describing: message)) }
            else                     { logMessage.append(" nil") }
        }
        
        if LogSetup.saveMessages {
            LogSetup.messages.append(LogMessage(type: type,
                                       location: "\(file)::\(function) - \(line)",
                                       message: String(describing: message)))
        }
        
        
        print(logMessage)
    }
}

public func Log(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
    _Log.log(message, withType: .info, file, function, line)
}

public func LogWarning(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
    _Log.log(message, withType: .warning, file, function, line)
}

public func LogError(_ message: Any? = noMessageString, _ file:String = #file, _ function:String = #function, _ line:Int = #line) {
    _Log.log(message, withType: .error, file, function, line)
}

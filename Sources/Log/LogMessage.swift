//
//  LogMessage.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 8/9/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public enum LogType {
    
    case info
    case warning
    case error
}

public class LogMessage {
    
    public var type:     LogType
    public var location: String
    public var message:  String
    
    public init(type: LogType, location: String, message: String) {
        
        self.type     = type
        self.location = location
        self.message  = message
    }
}

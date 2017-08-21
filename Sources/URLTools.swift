//
//  URLTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 8/21/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public class FailedToCreateUrlFromStringException : Error {
    
    public var localizedDescription: String {
        return "Failed to create url from string"
    }
}

public extension URL {
    
    static func withString(_ string: String) throws -> URL {
        
        if let url = URL(string: string) { return url }
        throw FailedToCreateUrlFromStringException()
    }
}

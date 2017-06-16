//
//  Errors.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/14/17.
//  Copyright © 2017 VladasZ All rights reserved.
//

import Foundation

class FailedToInitializeNodeError : Error {
    
    var localizedDescription: String { return "Failed to initialize node" }
}

class FailedToConvertNodeError : Error {
    
    var localizedDescription: String { return "Failed to convert node" }
}

class FailedToExtractNodeError : Error {
    
    var localizedDescription: String { return "Failed to extract node" }
}

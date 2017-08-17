//
//  NumbersCasting.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public extension Bool {
    
    var String: String { return self ? "true" : "false" }
}

public extension String {
    
    var Double: Double? { return Swift.Double(self) }
    var Int:    Int?    { return Swift.Int(self)    }
    var Bool:   Bool    { return self == "true"     }
}

public extension Int {
    
    var Double: Double   { return Swift.Double(self) }
    var String: String   { return Swift.String(self) }
}

public extension Double {
    
    var Int:    Int      { return Swift.Int(self)    }
    var String: String   { return Swift.String(self) }
}

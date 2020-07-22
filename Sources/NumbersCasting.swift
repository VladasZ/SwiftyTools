//
//  NumbersCasting.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit


public extension Bool {
    var toString: String { return self ? "true" : "false" }
}

public extension String {
    var toDouble: Double? { return Swift.Double(self) }
    var toInt:    Int?    { return Swift.Int(self)    }
    var toBool:   Bool    { return self == "true"     }
}

public extension Int {
    var toDouble:  Double  { return Swift.Double(self)  }
    var toString:  String  { return Swift.String(self)  }
    var toCGFloat: CGFloat { return UIKit.CGFloat(self) }
}

public extension Double {
    var toInt:    Int      { return Swift.Int(self)    }
    var toString: String   { return Swift.String(self) }
}

public extension CGFloat {
    var toInt:    Int      { return Swift.Int(self) }
    var toString: String   { "\(self)"              }
}

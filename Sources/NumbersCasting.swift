//
//  NumbersCasting.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit


public extension Int {
    var toDouble:  Double  { Double (self) }
    var toCGFloat: CGFloat { CGFloat(self) }
}

public extension Double {
    var toInt:   Int   { Int  (self) }
    var toFloat: Float { Float(self) }
}

public extension CGFloat {
    var toInt: Int { Int(self) }
}

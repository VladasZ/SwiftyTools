//
//  ArrayTools.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 4/7/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation

public extension Array where Element : Hashable {
    
    var unique: [Element] { return Array(Set(self)) }
}

public extension Array {
    
    var randomElement: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
}

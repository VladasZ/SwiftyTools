//
//  ArrayTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 4/7/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation

public extension Array where Element : Hashable {
    public var unique: [Element] {
        return Array(Set(self))
    }
}

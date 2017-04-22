//
//  ArrayTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 4/7/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}

//
//  DictionaryTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 11/29/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public func += <K, V> (left: inout [K : V], right: [K : V]) {
    for (k, v) in right {
        left[k] = v
    }
}

public func + <K, V> (left: [K : V], right: [K : V]) -> [K : V] {
    var dict = [K : V]()
    for (k, v) in right { dict[k] = v }
    for (k, v) in left { dict[k] = v }
    return dict
}

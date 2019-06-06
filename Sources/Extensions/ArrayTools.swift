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
    var randomElement: Element? {
        if count == 0 { return nil }
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Array where Iterator.Element : Equatable {
    
    func random(_ count: Int) -> [Element]? {
        if count == 0 { return nil }
        var result = [Element]()
        for _ in 0..<count { result.append(randomExcept(result)!) }
        return result
    }
    
    func randomExcept(_ element: Element) -> Element?  {
        var random = randomElement
        if count == 1 { Log.warning(); return random }
        while random == element { random = randomElement }
        return random
    }
    
    func randomExcept(_ elements: [Element]) -> Element?  {
        if count == 0 { return nil }
        var random = randomElement
        if count <= elements.count { Log.warning(); return random }
        while elements.contains(random!) { random = randomElement }
        return random
    }
    
    mutating func popRandom() -> Element? {
        if count == 0 { Log.error(); return first! }
        let random = randomElement
        let index = self.firstIndex { $0 == random }!
        remove(at: index)
        return random
    }
}

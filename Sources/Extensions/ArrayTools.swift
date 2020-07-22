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
    var randomElement: Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

//MARK: - Deletion

public extension Array where Iterator.Element : Equatable {

    mutating func remove(_ element: Element) {
        guard let index = firstIndex(of: element) else { LogWarning(); return }
        remove(at: index)
    }
    
    mutating func remove(_ elements: [Element]) {
        for element in elements { remove(element) }
    }
    
}

//MARK: - Random

public extension Array where Iterator.Element : Equatable {
    
    func random(_ count: Int) -> [Element] {
        var result = [Element]()
        for _ in 0..<count { result.append(randomExcept(result)) }
        return result
    }
    
    func randomExcept(_ element: Element) -> Element  {
        var random = randomElement
        while random == element { random = randomElement }
        return random
    }
    
    func randomExcept(_ elements: [Element]) -> Element  {
        var random = randomElement
        while elements.contains(random) { random = randomElement }
        return random
    }
    
    mutating func popRandom() -> Element {
        let random = randomElement
        let index = self.firstIndex { $0 == random }!
        remove(at: index)
        return random
    }
}

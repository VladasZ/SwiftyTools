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

public extension Array where Iterator.Element : Equatable {
    
    
    func randomExcept(_ element: Element) -> Element  {
        
        var random = randomElement
        if count == 1 { Log.warning(); return random }
        while random == element { random = randomElement }
        return random
    }
    
    func randomExcept(_ elements: [Element]) -> Element  {
        
        var random = randomElement
        if count <= elements.count { Log.warning(); return random }
        while elements.contains(random) { random = randomElement }
        return random
    }
}

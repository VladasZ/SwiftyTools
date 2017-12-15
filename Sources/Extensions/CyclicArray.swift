//
//  CyclicArray.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 7/7/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation
import ObjectiveC

fileprivate struct AssociatedKeys {
    static var currentCycleIndex = "currentCycleIndex"
}

fileprivate class CycleDummy { }
fileprivate let cycleDummy = CycleDummy()

public extension Array {
    
    private var currentCycleIndex: Int {
        get {
            if let value = objc_getAssociatedObject(cycleDummy, &AssociatedKeys.currentCycleIndex) as? Int {
                return value
            }
            else {
                objc_setAssociatedObject(cycleDummy, &AssociatedKeys.currentCycleIndex, 0, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return 0
            }
        }
        set {
            objc_setAssociatedObject(cycleDummy, &AssociatedKeys.currentCycleIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    mutating func next() -> Element {
        
        let element = self[currentCycleIndex]
        
        if currentCycleIndex == count - 1 { currentCycleIndex = 0 }
        else { currentCycleIndex = currentCycleIndex + 1 }
        
        return element
    }
}

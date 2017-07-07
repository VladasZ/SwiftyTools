//
//  AssociatedObjects.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 7/7/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

fileprivate struct AssociatedClass {
    
    var type: Any
    var values: [String : Any]
}

fileprivate var objects = [AssociatedClass]()

class AssociatedObjects {
    
    private func getClass(_ class: Any) -> AssociatedClass {
        
        return objects.first!
    }
    
    func setValue(_ value: Any, forClass class: Any, key: Any) {
        
        
    }
    
    func valueForClass(_ class: Any, key: String) -> Any {
        
        return 5
    }
}

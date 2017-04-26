//
//  Form.swift
//  swiftSand
//
//  Created by Vladas Zakrevskis on 4/24/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

open class LeForm {
    
    open var elements: [FormElement] {
        return [FormElement]()
    }
    
    public init() { }
    
    @discardableResult public func validate(_ completion: ((FormError?) -> ())? = nil) -> FormError? {
        
        for element in elements {
            
            if let error = element.validate() {
                if let completion = completion { completion(error) }
                return error
            }
        }
        
        if let completion = completion { completion(nil) }
        return nil
    }
}
//
//  StringTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 3/1/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//


import Foundation

public extension String {
    
    var isValidEmail: Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var url: URL? { return URL(string: self) }

}

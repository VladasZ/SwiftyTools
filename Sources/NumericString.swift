//
//  NumericString.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 7/21/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public class NumericString {
    
    private var firstForm:  String
    private var secontForm: String
    private var thirdForm:  String
    
    public init(_ firstForm: String, _ secontForm: String, _ thirdForm: String) {
        
        self.firstForm  = firstForm
        self.secontForm = secontForm
        self.thirdForm  = thirdForm
    }
    
    public func withNumber(_ number: Int) -> String {
        
        let teenMod = number % 100
        
        if  11...14 ~= teenMod { return thirdForm }
        else {
            
            let mod = number % 10
            
            switch (mod)
            {
            case 1:     return firstForm
            case 2...4: return secontForm
            default:    return thirdForm
            }
        }
    }
}

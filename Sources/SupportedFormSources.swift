//
//  SupportedFormSources.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 4/24/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

extension UITextField : FormSource {
    
    public var value: String? {
        get { return text }
        set { text = newValue }
    }
    
    public var intValue: Int? {
        get { return Int(text ?? "") }
        set { text = String(describing: newValue) }
    }
}

extension UITextView : FormSource {
    
    public var value: String? {
        get { return text }
        set { text = newValue }
    }
    
    public var intValue: Int? {
        get { return Int(text ?? "") }
        set { text = String(describing: newValue) }
    }
}


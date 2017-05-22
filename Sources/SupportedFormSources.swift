//
//  SupportedFormSources.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 4/24/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public protocol FormSource {
    
    var value:     String? { get set }
    var intValue:  Int?    { get set }
    var isNumeric: Bool    { get set }
    var isEmail:   Bool    { get set }
    func resetInputType()
}

extension UITextField : FormSource {
    
    public var isNumeric: Bool {
        get { return keyboardType == .numberPad }
        set {
            if newValue { keyboardType = .numberPad }
            else        { keyboardType = .default   }
        }
    }
    
    public var isEmail: Bool {
        get { return keyboardType == .emailAddress }
        set {
            if newValue { keyboardType = .emailAddress }
            else        { keyboardType = .default   }
        }
    }
    
    public var value: String? {
        get { return text }
        set { text = newValue }
    }
    
    public var intValue: Int? {
        get { return Int(text ?? "") }
        set { text = String(describing: newValue) }
    }
    
    public func resetInputType() { keyboardType = .default }
}

extension UITextView : FormSource {
    
    public var isNumeric: Bool {
        get { return keyboardType == .numberPad }
        set {
            if newValue { keyboardType = .numberPad }
            else        { keyboardType = .default   }
        }
    }
    
    public var isEmail: Bool {
        get { return keyboardType == .emailAddress }
        set {
            if newValue { keyboardType = .emailAddress }
            else        { keyboardType = .default   }
        }
    }
    
    public var value: String? {
        get { return text }
        set { text = newValue }
    }
    
    public var intValue: Int? {
        get { return Int(text ?? "") }
        set { text = String(describing: newValue) }
    }
    
    public func resetInputType() { keyboardType = .default }
}


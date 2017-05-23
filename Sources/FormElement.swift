//
//  FormElement.swift
//  SwitfTools
//
//  Created by Vladas Zakrevskis on 4/24/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public enum FormError {
    
    case empty(FormElement)
    case isNotEmail(FormElement)
    case tooShort(FormElement)
    case tooLong(FormElement)
    case notEqualElement(FormElement)
    case noSource(FormElement)
}

public class FormElement {
    
    private var _required  = false
    private var _isEmail   = false
    private var _trim      = true
    private var _minLength: Int?
    private var _maxLength: Int?
    private var _mustBeEqualElement: FormElement?
    private var _isPassword = false
    
    public var isNumeric = false
    public var caption = ""
    
    public var source: FormSource?
    
    public var isEmpty: Bool {
        
        return source?.value == nil || source?.value == ""
    }
    
    public var storedValue: String = ""
    
    public var value: String? {
        get {
            if _trim { return source?.value?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
            return source?.value
        }
        set {
            source?.value = newValue
        }
    }
    
    public var intValue: Int? {
        get { return source?.intValue }
        set { source?.intValue = newValue }
    }
    
    public var error: String?
    
    public init(required: Bool = false, isEmail: Bool = false, minLength: Int? = nil) {
    
        _required  = required
        _isEmail   = isEmail
        _minLength = minLength
    }
    
    @discardableResult public func bindTo(_ source: FormSource) -> FormElement {
        
        self.source = source
        self.source?.resetInputType()
        if _isEmail    { self.source?.isEmail    = true }
        if isNumeric   { self.source?.isNumeric  = true }
        if _isPassword { self.source?.isPassword = true }
        
        return self
    }
    
    @discardableResult public func setCaption(_ caption: String) -> FormElement {
        
        self.caption = caption
        return self
    }    
    
    @discardableResult public func required() -> FormElement {
        
        _required = true
        return self
    }
    
    @discardableResult public func isEmail() -> FormElement {
        
        _isEmail = true
        return self
    }
    
    @discardableResult public func isNumber() -> FormElement {
        
        isNumeric = true
        return self
    }
    
    @discardableResult public func isPassword() -> FormElement {
        
        _isPassword = true
        return self
    }
    
    @discardableResult public func maxLength(_ maxLength: Int) -> FormElement {
        
        _maxLength = maxLength
        return self
    }
    
    @discardableResult public func minLength(_ minLength: Int) -> FormElement {
        
        _minLength = minLength
        return self 
    }
    
    @discardableResult public func equalTo(_ element: FormElement) -> FormElement {
        
        _mustBeEqualElement = element
        return self
    }
    
    @discardableResult public func noTrim() -> FormElement {
        
        _trim = false
        return self
    }
    
    public func validate() -> FormError? {
        
        guard let source = source else { return .noSource(self) }
        
        if _required {
            if (source.value ?? "").isEmpty { return .empty(self) }
        }
        
        if _isEmail {
            if !(source.value ?? "").isValidEmail { return .isNotEmail(self) }
        }
        
        if let maxLength = _maxLength {
            if (source.value ?? "").characters.count > maxLength { return .tooLong(self) }
        }
        
        if let minLength = _minLength {
            if (source.value ?? "").characters.count < minLength { return .tooShort(self) }
        }
        
        if let equalElement = _mustBeEqualElement {
            if equalElement.value != self.value { return .notEqualElement(self) }
        }
        
        return nil
    }
}

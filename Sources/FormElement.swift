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
    case invalidLength(FormElement)
    case notEqualElement(FormElement)
    case noSource(FormElement)
}

public class FormElement {
    
    private var _required  = false
    private var _isEmail   = false
    private var _trim      = true
    private var _minLength: Int?
    private var _maxLength: Int?
    private var _exactLength: Int?
    private var _mustBeEqualElement: FormElement?
    private var _isPassword = false
    private var _range: CountableClosedRange<Int>? { didSet { didSetRange(_range) } }
    private var _rangeArray: [String]?
    private var _rangePostfix: String?
    
    public var isDropDown: Bool { return _rangeArray != nil }
    public var isNumeric = false
    public var caption = ""
    public var customType: String?
    
    public var source: FormSource?
    
    public var isEmpty: Bool {
        
        return value == ""
    }
    
    public var value: String = "" {
        didSet {
            source?.value = value
        }
    }
    
    public var range: [String]? { return _rangeArray }
    public var rangePostfix: String? { return _rangePostfix }
    
    public var customValue: Any?
    
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
    
    @discardableResult public func setRange(_ elements: [String]) -> FormElement {
        
        _rangeArray = elements
        return self
    }
    
    @discardableResult public func setRange(_ elements: CountableClosedRange<Int>) -> FormElement {
        
        _range = elements
        return self
    }
    
    @discardableResult public func setRangePostfix(_ postfix: String) -> FormElement {
        
        _rangePostfix = postfix
        return self
    }
    
    @discardableResult public func required(_ required: Bool = true) -> FormElement {
        
        _required = required
        return self
    }
    
    @discardableResult public func isEmail(_ isEmail: Bool = true) -> FormElement {
        
        _isEmail = isEmail
        return self
    }
    
    @discardableResult public func isNumber(_ isNumber: Bool = true) -> FormElement {
        
        isNumeric = isNumber
        return self
    }
    
    @discardableResult public func isPassword(_ isPassword: Bool = true) -> FormElement {
        
        _isPassword = isPassword
        return self
    }
    
    @discardableResult public func exactLength(_ exactLength: Int) -> FormElement {
        
        _exactLength = exactLength
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
        
        if let exactLength = _exactLength {
            
            if value.characters.count != exactLength { return .invalidLength(self) }
        }
        
        return nil
    }
    
    //MARK: - Additional methods
    
    private func didSetRange(_ range: CountableClosedRange<Int>?) {
        
        guard let range = range else { return }
        
        var array = [String]()
        for i in range { array.append(String(i)) }
        _rangeArray = array
    }
}

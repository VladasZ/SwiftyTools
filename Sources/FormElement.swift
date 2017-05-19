//
//  FormElement.swift
//  SwitfTools
//
//  Created by Vladas Zakrevskis on 4/24/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public protocol FormSource {
    
    var value: String? { get set }
    var intValue: Int? { get set }
}

public enum FormError {
    
    case empty
    case isNotEmail
    case tooShort
    case notEqualSources
    case noSource
}

public class FormElement {
    
    private var _required = false
    private var _isEmail  = false
    private var _trim     = true
    private var _minLength: Int?
    private var _mustBeEqualSource: FormSource?
    
    public var source: FormSource?
    
    public var isEmpty: Bool {
        
        return source?.value == nil || source?.value == ""
    }
    
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
    
    @discardableResult public func minLength(_ minLength: Int) -> FormElement {
        
        _minLength = minLength
        return self 
    }
    
    @discardableResult public func equalTo(_ source: FormSource) -> FormElement {
        
        _mustBeEqualSource = source
        return self
    }
    
    @discardableResult public func noTrim() -> FormElement {
        
        _trim = false
        return self
    }
    
    public func validate() -> FormError? {
        
        guard let source = source else { return .noSource }
        
        if _required {
            if (source.value ?? "").isEmpty { return .empty }
        }
        
        if _isEmail {
            if !(source.value ?? "").isValidEmail { return .isNotEmail }
        }
        
        if let minLength = _minLength {
            if (source.value ?? "").characters.count < minLength { return .tooShort }
        }
        
        if let equalSource = _mustBeEqualSource {
            if equalSource.value != self.value { return .notEqualSources }
        }
        
        return nil
    }
}

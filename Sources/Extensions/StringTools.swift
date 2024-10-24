//
//  StringTools.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 3/1/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import Foundation


public extension String {
    
    private static let letters = ["a", "b", "c", "d", "e", "f", "g", "i", "j", "k", "l", "m",
                                  "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    static var randomWord: String {
        var string = ""
        for _ in 0...random(8) { string.append(letters[random(letters.count)]) }
        return string
    }
    
    static var randomSentence: String {
        var string = String.randomWord
        for _ in 0...random(40) { string.append(" \(String.randomWord)") }
        return string
    }
    
    var firstLetter: String {
        return String(prefix(1))
    }
    
    var lastPathComponent: String {
        return self.components(separatedBy: "/").last ?? ""
    }
    
    var withoutFractionPart: String {
        if range(of: ".") != nil { return components(separatedBy: ".").first ?? ""}
        else { return self }
    }
    
    func insert(string: String, at ind: Int) -> String {
        return  String(self.prefix(ind)) + string + String(self.suffix(self.count - ind))
    }
    
    private static let nums: Set<Swift.Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        return Set(self).isSubset(of: String.nums)
    }
    
    var withoutLetters: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var containsWhitespace : Bool {
        return (rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    func remove(_ characters: String) -> String {
        return components(separatedBy: CharacterSet(charactersIn: characters)).joined()
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    var anyInt: Int {
        let target = withoutLetters
        if (withoutLetters.isEmpty) {
            return -1
        }
        return Int(target)!
    }
    
}

public extension String {
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
}

public extension String {
    
    func fromBase64() -> String {
        guard let data = Data(base64Encoded: self) else {
            return ""
        }
        return Swift.String(data: data, encoding: .utf8) ?? ""
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func trim() -> String {
        let cleanString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleanString
    }
    
    var notEmpty: Bool {
        !isEmpty
    }
    
}

public extension Optional where Wrapped == String {
    
    var isEmpty: Bool {
        switch self {
        case .none: return true
        case let .some(string): return string.isEmpty
        }
    }
    
    var isValidEmail: Bool {
        switch self {
        case .none: return false
        case let .some(string): return string.isValidEmail
        }
    }
    
    func minimumLength(_ length: Int) -> String? {
        switch self {
        case .none: return nil
        case let .some(string): return string.count >= length ? string : nil
        }
    }
    
    var notEmptyOrNil: String? {
        switch self {
        case .none: return nil
        case let .some(string): return string.isEmpty ? nil : string
        }
    }
    
    var anyString: String {
        switch self {
        case .none: return ""
        case let .some(string): return string
        }
    }
}

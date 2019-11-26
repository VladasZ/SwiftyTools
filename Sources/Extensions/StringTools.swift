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
    
    private static let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
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
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var url: URL? { return URL(string: self) }

}

public extension String {
    
    func index(from: Int) -> Index {
         return self.index(startIndex, offsetBy: from)
     }

     func substring(from: Int) -> String {
         let fromIndex = index(from: from)
         return substring(from: fromIndex)
     }

     func substring(to: Int) -> String {
         let toIndex = index(from: to)
         return substring(to: toIndex)
     }

     func substring(with r: Range<Int>) -> String {
         let startIndex = index(from: r.lowerBound)
         let endIndex = index(from: r.upperBound)
         return substring(with: startIndex..<endIndex)
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
    
    var notEmpty: String? {
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

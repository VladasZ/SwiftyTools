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
}

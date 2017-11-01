//
//  Block.swift
//  SwiftLibs
//
//  Created by Vladas Zakrevskis on 6/14/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public class Block {
    
    //MARK: - Static properties
    
    public static var empty:     Block { return Block(value: "Empty Block") }
    public static var container: Block { return Block(value: [String : Any]()) }
    
    //MARK: - Properties
    
    public var value: Any!
    
    public var string:     String?         { return value as? String }
    public var int:        Int?            { return value as? Int    }
    public var double:     Double?         { return value as? Double }
    public var bool:       Bool?           { return value as? Bool   }
    public var dictionary: [String : Any]? { return value as? [String : Any] }
    
    public var JSONString: String {
        if value == nil { return "No value" }
        return (try? JSONSerialization.data(withJSONObject: value, options: []))?.JSONString ?? "No JSON data"
    }
    
    public var array:  [Block]? {
        
        guard let array = value as? [Any] else { return nil }
        return array.map { Block(value: $0) }
    }
    
    public subscript (_ key: String) -> Block? {
        
        guard let dict = value as? [String : Any] else { return nil }
        guard let value = dict[key] else { return nil }
        return Block(value: value)
    }
    
    //MARK: - Extraction
    
    public func extract<T>(_ key: String) throws -> T {
        
        guard let value: T = self[key]?.value as? T else {
            
            if self[key]?.value as? NSNull == nil { Log.error(key) }
            
            throw FailedToExtractBlockError() }
        return value
    }
    
    public func extract<T>(_ key: String) throws -> T where T : BlockConvertible {
        
        guard let block = self[key] else { Log.error(key); throw FailedToExtractBlockError() }
        return try T(block: block)
    }
    
    public func extract<T, T2>(_ key: String, _ convert: (T2) -> T) throws -> T  {
        
        guard let value = self[key]?.value as? T2 else { Log.error(key); throw FailedToConvertBlockError() }
        return convert(value)
    }
    
    public func extract<T>(_ key: String) throws -> [T] where T : BlockSupportedType {
        
        guard let array = self[key]?.array else {
            
              
            Log.error(key);
            
            throw FailedToExtractBlockError() }
        guard let result = (array.map { $0.value }) as? [T] else { Log.error(key); throw FailedToExtractBlockError() }
        return result
    }
    
    public func extract<T, T2>(_ key: String, _ convert: @escaping (T2) -> T) throws -> [T] where T : BlockSupportedType {
        
        guard let array = self[key]?.array else { Log.error(key); throw FailedToExtractBlockError() }

        return try array.map { (block) -> T in
            guard let value = block.value as? T2 else { Log.error(key); throw FailedToExtractBlockError() }
            return convert(value)
        }
    }
    
    public func extract<T>(_ key: String) throws -> [T] where T : BlockConvertible {
        
        guard let data = self[key],
              data.array != nil
        else { Log.error(key); throw FailedToExtractBlockError() }
        
        return try [T](block: data)
    }
    
    //MARK: - Serialization
    
    var data: Data? {
        
        guard let dictionary = dictionary else { Log.error(); return nil }
        return try? JSONSerialization.data(withJSONObject: dictionary, options: [])
    }
    
    public func append(_ key: String, _ value: BlockConvertible?) {
        
        guard let value = value else { return }
        guard var dictionary = dictionary else { Log.error(key); return }
        guard let data = value.block.dictionary else { Log.error(key); return }
        
        dictionary[key] = data
        self.value = dictionary
    }
    
    public func append(_ key: String, _ value: [BlockConvertible]?) {
        
        guard let value = value else { return }
        guard var dictionary = dictionary else { Log.error(key); return }
        
        dictionary[key] = value.map{ value -> [String : Any] in
            if let dictionary = value.dictionary { return dictionary }
            else { Log.error(); return ["error" : "error"] }
        }
        self.value = dictionary
        return
    }
    
    public func append(_ key: String, _ value: BlockSupportedType?, appendsNil: Bool = false) {
        
        guard var dictionary = dictionary else { Log.error(); return }
        
        if appendsNil {
            
            if let value = value { dictionary[key] = value }
            else                 { dictionary[key] = NSNull() }
        }
        else {
            
            guard let value = value else { return }
            if let value = value as? String { if value.isEmpty { return } }
            dictionary[key] = value
        }
        
        self.value = dictionary
    }
    
    public func append(_ key: String, _ value: [BlockSupportedType]?) {
        
        guard let value = value else { return }
        guard var dictionary = dictionary else { Log.error(); return }
                
        dictionary[key] = value
        self.value = dictionary
    }
    
    public func appendStringToArray(_ string: String) {
        
        guard let stringData = Block(string: string) else { Log.error(); return }
        guard var array = self.array else { Log.error(); return }
        array.append(stringData)
        value = array.map { $0.value }
    }
    
    //MARK: - Initialization
    
    public init(value: Any) {
        
        self.value = value
    }
    
    public init?(string: String) {
        
        guard let data = string.data(using: .utf8) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
        value = json
    }
    
    public init?(data: Data?) {
        
        guard let data = data else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
        value = json
    }
    
    public init(dictionary: [String : Any]) {
        
        self.value = dictionary
    }
}

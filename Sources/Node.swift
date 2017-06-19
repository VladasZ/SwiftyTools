//
//  Node.swift
//  SwiftLibs
//
//  Created by Vladas Zakrevskis on 6/14/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public class Node {
    
    //MARK: - Static properties
    
    public static var empty:     Node { return Node(value: "Empty Node") }
    public static var container: Node { return Node(value: [String : Any]()) }
    
    //MARK: - Properties
    
    public var value: Any!
    
    public var string:     String?         { return value as? String }
    public var int:        Int?            { return value as? Int    }
    public var double:     Double?         { return value as? Double }
    public var bool:       Bool?           { return value as? Bool   }
    public var dictionary: [String : Any]? { return value as? [String : Any] }
    
    public var Array:  [Node]? {
        
        guard let array = value as? [Any] else { return nil }
        return array.map { Node(value: $0) }
    }
    
    public subscript (_ key: String) -> Node? {
        
        guard let dict = value as? [String : Any] else { return nil }
        guard let value = dict[key] else { return nil }
        return Node(value: value)
    }
    
    //MARK: - Extraction
    
    public func extract<T>(_ key: String) throws -> T {
        
        guard let value: T = self[key]?.value as? T else {
            
            
            
            Log.error(key);
            
            
            
            throw FailedToExtractNodeError() }
        return value
    }
    
    public func extract<T>(_ key: String) throws -> T where T : NodeConvertible {
        
        guard let node = self[key] else { Log.error(key); throw FailedToExtractNodeError() }
        return try T(node: node)
    }
    
    public func extract<T, T2>(_ key: String, _ convert: (T2) -> T) throws -> T  {
        
        guard let value = self[key]?.value as? T2 else { Log.error(key); throw FailedToConvertNodeError() }
        return convert(value)
    }
    
    public func extract<T>(_ key: String) throws -> [T] where T : NodeSupportedType {
        
        guard let array = self[key]?.Array else {
            
            
            Log.error(key);
            
            throw FailedToExtractNodeError() }
        guard let result = (array.map { $0.value }) as? [T] else { Log.error(key); throw FailedToExtractNodeError() }
        return result
    }
    
    public func extract<T, T2>(_ key: String, _ convert: @escaping (T2) -> T) throws -> [T] where T : NodeSupportedType {
        
        guard let array = self[key]?.Array else { Log.error(key); throw FailedToExtractNodeError() }

        return try array.map { (node) -> T in
            guard let value = node.value as? T2 else { Log.error(key); throw FailedToExtractNodeError() }
            return convert(value)
        }
    }
    
    public func extract<T>(_ key: String) throws -> [T] where T : NodeConvertible {
        
        guard let data = self[key],
              data.Array != nil
        else { Log.error(key); throw FailedToExtractNodeError() }
        
        return try [T](node: data)
    }
    
    //MARK: - Serialization
    
    var data: Data? {
        
        guard let dictionary = dictionary else { Log.error(); return nil }
        return try? JSONSerialization.data(withJSONObject: dictionary, options: [])
    }
    
    public func append(_ key: String, _ value: NodeConvertible?) {
        
        guard let value = value else { return }
        guard var dictionary = dictionary else { Log.error(key); return }
        guard let data = value.node.dictionary else { Log.error(key); return }
        
        dictionary[key] = data
        self.value = dictionary
    }
    
    public func append(_ key: String, _ value: [NodeConvertible]?) {
        
        guard let value = value else { return }
        guard var dictionary = dictionary else { Log.error(key); return }
        
        dictionary[key] = value.map{ value -> [String : Any] in
            if let dictionary = value.dictionary { return dictionary }
            else { Log.error(); return ["error" : "error"] }
        }
        self.value = dictionary
        return
    }
    
    public func append(_ key: String, _ value: NodeSupportedType?) {
        
        guard let value = value else { return }
        guard var dictionary = dictionary else { Log.error(); return }
        
        if let value = value as? String { if value.isEmpty { return } }
        
        dictionary[key] = value
        self.value = dictionary
    }
    
    public func append(_ key: String, _ value: [NodeSupportedType]?) {
        
        guard let value = value else { return }
        guard var dictionary = dictionary else { Log.error(); return }
                
        dictionary[key] = value
        self.value = dictionary
    }
    
    //MARK: - Initialization
    
    public init(value: Any) {
        
        self.value = value
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

//
//  Node.swift
//  SwiftLibs
//
//  Created by Vladas Zakrevskis on 6/14/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

class Node {
    
    //MARK: - Properties
    
    private var value: Any!
    
    var String: String? { return value as? String }
    var Int:    Int?    { return value as? Int    }
    var Double: Double? { return value as? Double }
    var Bool:   Bool?   { return value as? Bool   }
    
    var Array:  [Node]? {
        
        guard let array = value as? [Any] else { return nil }
        return array.map { Node(value: $0) }
    }
    
    subscript (_ key: String) -> Node? {
        
        guard let dict = value as? [String : Any] else { return nil }
        guard let value = dict[key] else { return nil }
        return Node(value: value)
    }
    
    //MARK: - Extraction
    
    func extract<T>(_ key: String) throws -> T {
        
        guard let value: T = self[key]?.value as? T else { Log.error(key); throw FailedToExtractNodeError() }
        return value
    }
    
    func extract<T, T2>(_ key: String, _ convert: (T2) -> T) throws -> T  {
        
        guard let value = self[key]?.value as? T2 else { Log.error(key); throw FailedToConvertNodeError() }
        return convert(value)
    }
    
    func extract<T>(_ key: String) throws -> [T] where T : NodeSupportedType {
        
        guard let array = self[key]?.Array else { Log.error(key); throw FailedToExtractNodeError() }
        guard let result = (array.map { $0.value }) as? [T] else { Log.error(key); throw FailedToExtractNodeError() }
        return result
    }
    
    func extract<T, T2>(_ key: String, _ convert: @escaping (T2) -> T) throws -> [T] where T : NodeSupportedType {
        
        guard let array = self[key]?.Array else { Log.error(key); throw FailedToExtractNodeError() }

        return try array.map { (node) -> T in
            guard let value = node.value as? T2 else { Log.error(key); throw FailedToExtractNodeError() }
            return convert(value)
        }
    }
    
    func extract<T>(_ key: String) throws -> [T] where T : NodeConvertible {
        
        guard let data = self[key],
              data.Array != nil
        else { Log.error(key); throw FailedToExtractNodeError() }
        
        return try [T](node: data)
    }
    
    //MARK: - Initialization
    
    init(value: Any) {
        
        self.value = value
    }
    
    init?(data: Data?) {
        
        guard let data = data else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
        value = json
    }
}

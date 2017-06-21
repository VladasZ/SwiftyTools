//
//  NodeConvertible.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 6/14/17.
//  Copyright © 2017 VladasZ All rights reserved.
//

import Foundation

public protocol NodeConvertible : class {
    
    var node: Node { get }
    
    init(data: Data?) throws
    init(node: Node) throws
}

public extension NodeConvertible {
    
    var node: Node                  { return Node.empty      }
    var data: Data?                 { return node.data       }
    var dictionary: [String : Any]? { return node.dictionary }
    
    init(data: Data?) throws {
        
        guard let data = data else { throw FailedToInitializeNodeError() }
        guard let node = Node(data: data) else { throw FailedToInitializeNodeError() }
        try self.init(node: node)
    }
}

public extension Array where Element: NodeConvertible {
    
    var node: Node {
        
        Log.error()
        return Node.empty//map { $0.node }
    }
    
    init(data: Data?) throws {
        
        guard let data = data else { throw FailedToInitializeNodeError() }
        guard let node = Node(data: data) else { throw FailedToInitializeNodeError() }
        try self.init(node: node)
    }
    
    init(node: Node) throws {
        
        let array = node.array ?? [node]
        var result = [Element]()
        
        array.forEach {
            
            if let element = try? Element(node: $0) { result.append(element) }
            else {
                
                Log.error()
            }
        }
        
        if array.count != 0 && result.count == 0 { throw FailedToInitializeNodeError() }
        
        self = result
    }
}

public extension Data {
    
    public var JSONString: String {
        
        return String(data: self, encoding: .utf8) ?? "not a JSONString"
    }
}

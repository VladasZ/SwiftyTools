//
//  NodeConvertible.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/14/17.
//  Copyright © 2017 VladasZ All rights reserved.
//

import Foundation

protocol NodeConvertible : class {
    
    init(data: Data?) throws
    init(node: Node) throws
}

extension NodeConvertible {
    
    init(data: Data?) throws {
        
        guard let data = data else { throw FailedToInitializeNodeError() }
        guard let node = Node(data: data) else { throw FailedToInitializeNodeError() }
        try self.init(node: node)
    }
}

extension Array where Element: NodeConvertible {
    
    init(data: Data?) throws {
        
        guard let data = data else { throw FailedToInitializeNodeError() }
        guard let node = Node(data: data) else { throw FailedToInitializeNodeError() }
        try self.init(node: node)
    }
    
    init(node: Node) throws {
        
        let array = node.Array ?? [node]
        self = try array.map { try Element(node: $0) }
    }
}

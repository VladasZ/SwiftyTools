//
//  BlockConvertible.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 6/14/17.
//  Copyright © 2017 VladasZ All rights reserved.
//

import Foundation

public protocol BlockConvertible : class {
    
    var block: Block { get }
    
    init(data: Data?) throws
    init(block: Block) throws
}

public extension BlockConvertible {
    
    var block: Block                { return Block.empty      }
    var data: Data?                 { return block.data       }
    var dictionary: [String : Any]? { return block.dictionary }
    
    init(data: Data?) throws {
        
        guard let data = data else { throw FailedToInitializeBlockError() }
        guard let block = Block(data: data) else { throw FailedToInitializeBlockError() }
        try self.init(block: block)
    }
}

public extension Array where Element: BlockConvertible {
    
    var block: Block {
        
        Log.error()
        return Block.empty//map { $0.block }
    }
    
    init(data: Data?) throws {
        
        guard let data = data else { throw FailedToInitializeBlockError() }
        guard let block = Block(data: data) else { throw FailedToInitializeBlockError() }
        try self.init(block: block)
    }
    
    init(block: Block?) throws {
        
        guard let block = block else { throw FailedToInitializeBlockError() }
        
        let array = block.array ?? [block]
        var result = [Element]()

        array.forEach {
            
            if let element = try? Element(block: $0) { result.append(element) }
            else {
                
                Log.error()
            }
        }
        
        if array.count != 0 && result.count == 0 { throw FailedToInitializeBlockError() }
        
        self = result
    }
}

public extension Data {
    
    public var JSONString: String {
        
        return String(data: self, encoding: .utf8) ?? "not a JSONString"
    }
}

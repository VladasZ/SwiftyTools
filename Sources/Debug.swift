//
//  Debug.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 7/14/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

public class Debug {
    
    private static var callCouterData = [String : Int]()
    
    public static func callCounter(_ file: String = #file, _ function:String = #function, _ line: Int = #line) {
        
        let id = "\(file)\(line)"
        
        if let data = callCouterData[id] {
            
            Log.info("call count: \(data)", file, function, line)
            callCouterData[id]! += 1
        }
        else {
            Log.info("call count: \(1)", file, function, line)
            callCouterData[id] = 1
        }
    }
}

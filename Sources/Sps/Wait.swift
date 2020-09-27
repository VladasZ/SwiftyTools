//
//  Wait.swift
//  Actors Pocket Guide
//
//  Created by Vladas Zakrevskis on 9/27/20.
//  Copyright © 2020 Atomichronica. All rights reserved.
//

class Wait {
    
    private let _start: () -> ()
    private let _end:   () -> ()
    
    init(_ start: @escaping () -> (), end: @escaping () -> ()) {
        _start = start
        _end   = end
    }
    
    func start() { sync { self._start() } }
    func end()   { sync { self._end()   } }
    
}

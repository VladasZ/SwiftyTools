//
//  Sps.swift
//  Actors Pocket Guide
//
//  Created by Vladas Zakrevskis on 9/27/20.
//  Copyright © 2020 Atomichronica. All rights reserved.
//

import Foundation


typealias Completion = (_ error: String?) -> ()

typealias Ok     = () -> ()
typealias Fail   = (_ error: String) -> ()
typealias Got<T> = (_ value: T)      -> ()

typealias Done       = (_ error: String?            ) -> ()
typealias Fetched<T> = (_ error: String?, _ value: T) -> ()

typealias Do       = (@escaping Done      ) -> ()
typealias Fetch<T> = (@escaping Fetched<T>) -> ()

typealias Ask<Request, Result> = (_ request: Request, _ completion: @escaping Fetched<Result>) -> ()

 
func sps<Request, Result>(_ job: @escaping Ask<Request, Result>,
                          _ request: Request,
                          got:  @escaping Got<Result>,
                          fail: @escaping Fail) {
    
    job(request) { error, object in
        if let error = error { fail(error) }
        else                 { got(object) }
    }
    
}

func sps<Request, Result>(_ wait: Wait,
                          _ job: @escaping Ask<Request, Result>,
                          _ request: Request,
                          got:  @escaping Got<Result>,
                          fail: @escaping Fail) {
    
    wait.start()
    job(request) { error, object in
        if let error = error { fail(error) }
        else                 { got(object) }
        wait.end()
    }
    
}

//
//  Network.swift
//  NetworkTools
//
//  Created by Vladas Zakrevskis on 11/15/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

internal typealias CoreRequestCompletion = (_ error: NetworkError?, _ data: Data?) -> ()

public enum HTTPMethod {
    case get
    case post
}

public class Network {
    
    static let session = URLSession()
    
    static func request(_ url: URLConvertible?,
                        method: HTTPMethod = .get,
                        _ completion: @escaping CoreRequestCompletion) {
        guard let url = url else { completion(.invalidURL, nil); return }
        
        
        
        
    }
}

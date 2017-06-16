//
//  UIImageViewTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/16/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    func setWithURL(_ url: String, placeholder: UIImage? = nil) {
        
        if let placeholder = placeholder { image = placeholder }
        
        guard let imageURL = URL(string: url) else { Log.error(); return }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
                else { Log.error(); return }
            
            DispatchQueue.main.async() { self.image = image }
            
        }.resume()
    }
}

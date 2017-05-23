//
//  AttributedStrings.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 5/23/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension String {
    
    public func attributed(font: UIFont? = nil, color: UIColor = UIColor.black, underlined: Bool = false) -> NSMutableAttributedString {
        
        var attributes = [String : Any]()
        
        if let font = font {
            attributes[NSFontAttributeName] = font
        }
        
        attributes[NSForegroundColorAttributeName] = color

        if underlined {
            attributes[NSUnderlineStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue
        }
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
}

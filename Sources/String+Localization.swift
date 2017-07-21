//
//  String+Localization.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 7/14/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
    }
}

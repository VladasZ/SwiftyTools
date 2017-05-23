//
//  Localization.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 5/23/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension UILabel {
    
    @IBInspectable public var localizedString: String {
        set { text = NSLocalizedString(newValue, comment: "") }
        get { return "No localizedString getter" }
    }
}

public extension UIButton {
    
    @IBInspectable public var localizedString: String {
        set { setTitle(NSLocalizedString(newValue, comment: ""), for: .normal) }
        get { return "No localizedString getter" }
    }
}

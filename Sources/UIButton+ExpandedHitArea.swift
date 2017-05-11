//
//  UIButton+ExpandedHitArea.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/14/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

// http://stackoverflow.com/questions/808503/uibutton-making-the-hit-area-larger-than-the-default-hit-area

public class ExpandedHitAreaButton : UIButton {
    
    @IBInspectable public var hitArea:CGSize = CGSize(width: 100, height: 100)
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 { return nil }
        
        let buttonSize = self.bounds.size
        let widthToAdd = max(hitArea.width - buttonSize.width, 0)
        let heightToAdd = max(hitArea.height - buttonSize.height, 0)
        let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
        
        return (largerFrame.contains(point)) ? self : nil
    }
}

//
//  UIViewTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 4/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

fileprivate let ANIMATION_DURATION:TimeInterval = 0.211

//MARK: - Animations

public extension UIView {
    
    public func hideAnimated() {
        
        UIView.animate(withDuration: ANIMATION_DURATION,
                       animations: { self.alpha = 0},
                       completion: { _ in self.isHidden = true })
    }
    
    public func showAnimated() {
        
        self.isHidden = false
        UIView.animate(withDuration: ANIMATION_DURATION) { self.alpha = 1 }
    }
    
    public func setBackgroundColorAnimated(_ color:UIColor) {
        
        UIView.animate(withDuration: ANIMATION_DURATION) { self.backgroundColor = color }
    }
    
}

public extension UIView {
    
    @discardableResult public func circle() -> Self {
        
        clipsToBounds = true
        layer.cornerRadius = self.frame.size.height / 2
        return self
    }
    
    public func subviewWithTag(_ tag: Int) -> UIView? {
        
        for subview in self.subviews {
            if subview.tag == tag {
                return subview
            }
        }
        
        return nil
    }
    
    public static func named(_ nibName: String, bundle : Bundle? = nil) -> UIView? {
        
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}


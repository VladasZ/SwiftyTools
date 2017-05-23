//
//  UILabelTools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 4/28/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension UILabel {
    
    @IBInspectable public var localizedString: String {
        set { Log.info(NSLocalizedString(newValue, comment: "")); text = NSLocalizedString(newValue, comment: "") }
        get { return "No localizedString getter" }
    }
    
    public func rectForString(_ string: String) -> CGRect? {
        
        guard let nsText = text as NSString? else { return nil }
        let range = nsText.range(of: string)
        guard let rect = rectForCharacterRange(range: range) else { return nil }
        if rect.size.height == 0 || rect.size.width == 0 { return nil }
        return rect
    }
    
    public func rectForCharacterRange(range: NSRange) -> CGRect? {
        
        guard let attributedText = attributedText else { return nil }
        
        var glyphRange = NSRange()
        let layoutManager = NSLayoutManager()
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        
        layoutManager.addTextContainer(textContainer)
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
}

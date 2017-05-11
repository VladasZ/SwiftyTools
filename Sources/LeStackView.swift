//
//  LeStackView.swift
//  swiftSand
//
//  Created by Vladas Zakrevskis on 4/20/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public class LeStackView : UIView {
    
    //MARK: - Properties
    
    public var isHorizontal = true
    
    public var arrangedSubviews: [UIView]! {
        didSet {
            guard let subviews = arrangedSubviews else { print("❤️"); return }
            setupArrangedSubviews(subviews)
        }
    }
        
    private var spacing: CGFloat {
        
        return (isHorizontal ? frame.size.width : frame.size.height) / CGFloat(arrangedSubviews.count)
    }
    
    //MARK: - Initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    //MARK: - Internal Initialization
    
    private func setup () {
        
    }
    
    //MARK: - UI Setup
    
    private func centerPositionForViewAtIndex(_ index: Int) -> CGPoint {
        
        var x = spacing * CGFloat(index) + spacing / 2
        var y = (isHorizontal ? frame.size.height : frame.size.width) / 2
        
        if !isHorizontal { swap(&x, &y) }
        
        return CGPoint(x: x, y: y)
    }
    
    private func setupArrangedSubviews(_ subviews: [UIView]) {
        
        for i in 0...subviews.count - 1 {
            
            addSubview(subviews[i])
            subviews[i].center = centerPositionForViewAtIndex(i)
        }
    }
}


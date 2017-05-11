//
//  DatePicker.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/8/17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import UIKit


public class DatePicker : UIView {
    
    //MARK: - Properties
    
    public static var height: CGFloat = 215.0
    public static var backgroundColor: UIColor = UIColor.gray
    private static var pickerView: UIDatePicker!
    private static var picker: DatePicker!
    private static var completion: ((Date?) -> ())!
    
    
    private(set) public static var isHidden: Bool = true
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        DatePicker.pickerView = UIDatePicker(frame: CGRect(x: 0,
                                                y: 0,
                                                width: frame.size.width,
                                                height: frame.size.height))
        
        DatePicker.pickerView.backgroundColor = DatePicker.backgroundColor
        
        DatePicker.pickerView.datePickerMode = .date
        addSubview(DatePicker.pickerView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Appearance
    
    public static func pick(_ completion:@escaping (Date?) -> ()) {
        
        let window = keyWindow
        
        picker = DatePicker(frame:CGRect(x:0,
                                         y: window.frame.size.height,
                                         width: window.frame.size.width,
                                         height: DatePicker.height))
        
        self.completion = completion
        
        window.addSubview(picker)
        picker.hide(false, nil)
        isHidden = false
    }
    
    public static func finish() {
        
        isHidden = true
        completion(pickerView.date)
        picker.hide(true)
    }
    
    //MARK: - Animation
    
    func hide(_ hide:Bool, _ completion:((Bool) -> Void)? = nil) {
        
        let screenHeight = keyWindow.frame.size.height
        let newPosition = hide ? screenHeight : screenHeight - DatePicker.height
        
        UIView.animate(withDuration: 0.211,
                       animations: { self.frame.origin.y = newPosition },
                       completion: completion)
    }
}

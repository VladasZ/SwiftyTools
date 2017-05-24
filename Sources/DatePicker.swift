//
//  DatePicker.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/8/17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import UIKit

fileprivate var _backgroundColor = UIColor.gray
fileprivate var _doneButtonTextAligment: UIControlContentHorizontalAlignment = .center
fileprivate var _onFinishPicking: (() -> ())?

public class DatePicker : UIView {
    
    //MARK: - Properties
    
    private static var height: CGFloat = 215.0
    private static var doneButtonHeight: CGFloat = 50
    private static var doneButtonMargin: CGFloat = 24
    public static var locale: Locale?
    public static var doneButtonTitle: String?
    private static var pickerView: UIDatePicker!
    private static var picker: DatePicker!
    private static var completion: ((Date?) -> ())!
    
    public static func setBackgroundColor(_ color: UIColor) { _backgroundColor = color }
    public static func setDoneButtonTextAligment(_ aligment: UIControlContentHorizontalAlignment)
        { _doneButtonTextAligment = aligment  }
    
    private static var hasDoneButton: Bool { return doneButtonTitle != nil }
    
    private(set) public static var isHidden: Bool = true
    
    public static func onFinishPicking(_ action: @escaping () -> ()) {
        
        _onFinishPicking = action
    }
    
    //MARK: - Initialization
    init(frame: CGRect, hasDoneButton: Bool) {
        
        super.init(frame: frame)
        
        DatePicker.pickerView
            = UIDatePicker(frame:
                CGRect(x: 0,
                       y: (DatePicker.hasDoneButton ? DatePicker.doneButtonHeight : 0),
                       width: frame.size.width,
                       height: frame.size.height - (DatePicker.hasDoneButton ? DatePicker.doneButtonHeight : 0)))
        
        if let locale = DatePicker.locale { DatePicker.pickerView.locale = locale }
        
        DatePicker.pickerView.backgroundColor = _backgroundColor
        backgroundColor = _backgroundColor
        
        DatePicker.pickerView.datePickerMode = .date
        addSubview(DatePicker.pickerView)
        
        
        if hasDoneButton {
            
            let button = UIButton(frame: CGRect(x: DatePicker.doneButtonMargin,
                                                y: 0,
                                                width: frame.size.width - DatePicker.doneButtonMargin * 2,
                                                height: DatePicker.doneButtonHeight))
            
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitle(DatePicker.doneButtonTitle, for: .normal)
            button.contentHorizontalAlignment = _doneButtonTextAligment
            
            addSubview(button)
            
            button.addTarget(self, action: #selector(didPressDoneButton), for: .touchUpInside)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Appearance
    
    public static func pick(_ completion:@escaping (Date?) -> ()) {
        
        picker = createPicker()
        self.completion = completion
        
        keyWindow.addSubview(picker)
        picker.hide(false, nil)
        isHidden = false
    }
    
    public static func finish() {
        
        if isHidden { return }
        
        isHidden = true
        completion(pickerView.date)
        picker.hide(true)
    }
    
    //MARK: - UI
    
    private static func createPicker() -> DatePicker {
        
        return DatePicker(frame:CGRect(x:      0,
                                       y:      keyWindow.frame.size.height,
                                       width:  keyWindow.frame.size.width,
                                       height: height + (hasDoneButton ? doneButtonHeight : 0)),
                          hasDoneButton: hasDoneButton)
    }
    
    //MARK: - Animation
    
    func hide(_ hide:Bool, _ completion:((Bool) -> Void)? = nil) {
        
        let screenHeight = keyWindow.frame.size.height
        let newPosition =
            hide ?
                screenHeight :
                screenHeight - (DatePicker.height + (DatePicker.hasDoneButton ? DatePicker.doneButtonHeight : 0))
        
        UIView.animate(withDuration: 0.211,
                       animations: { self.frame.origin.y = newPosition },
                       completion: completion)
    }
    
    //MARK: - Actions
    
    func didPressDoneButton() {
        
        _onFinishPicking?()
        DatePicker.finish()
    }
}

//
//  Debug.swift
//  TransFix
//
//  Created by Vladas Zakrevskis on 3/29/17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import UIKit

public class Debug {
    
    public static var notImplementedMessage = "Not implemented yet"
    
    public static func notImplemented() {
        
        Alert.show(notImplementedMessage)
    }
    
    public static func check(_ object: Any?, error: String) {
        
        if object == nil { Log.error(error) }
    }
    
    public static func checkForNil(_ object: Any?, error: String) {
        
        if object != nil { Log.error(error) }
    }
    
    public static func execute(_ block: () -> ()) {
        
        block()
    }
    
    public static func executeOnSimulator(_ simulator: () -> (), device: () -> ()) {
        
        #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
            simulator()
        #else
            device()
        #endif
    }
    
    public static func addressOf<T: AnyObject>(_ object: T) -> Int {
        
        return unsafeBitCast(object, to: Int.self)
    }
    
    //MARK: - Debug button
    
    private static var button: UIButton!
    private static var debugButtonAction: (() -> ())!
    
    public static func onDebugButtonClick(_ action: @escaping () -> ()) {
        
        if button == nil {
            
            button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            button.addTarget(self, action: #selector(self.didPressDebugButton), for: .touchUpInside)
            button.backgroundColor = UIColor.gray
            button.alpha = 0.4
            keyWindow.addSubview(button)
        }
        
        debugButtonAction = action
    }
    
    @objc private static func didPressDebugButton() {
        
        debugButtonAction()
    }
}

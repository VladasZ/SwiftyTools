//
//  UITools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/16/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

public var topmostController: UIViewController {
    
    var topController = UIApplication.shared.keyWindow?.rootViewController;
    
    while topController?.presentedViewController != nil {
        topController = topController?.presentedViewController;
    }
    
    guard let controller = topController
        else { Log.error(); return UIViewController() }
    
    return controller
}

public var keyWindow: UIView {
    
    guard let window = UIApplication.shared.keyWindow
        else { Log.error(); return UIView() }
    
    return window
}

func openSettings() {
    
    guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString)
        else { Log.error(); return }
    
    UIApplication.shared.openURL(settingsURL)
}

//
//  Alert.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/10/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

public typealias AlertConfigurationBlock = ((AlertConfiguration) -> ())?

public class AlertConfiguration {
    
    var cancelLabel: String = Alert.cancelLabel
    var agreeLabel:  String = Alert.agreeLabel
    var errorLabel:  String = Alert.errorLabel
}

public struct Alert {
    
    public static var cancelLabel: String = "Cancel"
    public static var agreeLabel:  String = "OK"
    public static var errorLabel:  String = "Error"
    
    public static func show(_ message:String, configuration: AlertConfigurationBlock = nil, _ agreeAction: (() -> ())? = nil) {
        
        let conf = AlertConfiguration()
        configuration?(conf)
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: conf.agreeLabel, style: .default, handler: { action in
            if let agreeAction = agreeAction { agreeAction() }
        }))
        
        topmostController.present(alert, animated: true, completion: nil)
    }
        
    public static func error(_ message:String, configuration: AlertConfigurationBlock = nil) {
        
        let conf = AlertConfiguration()
        configuration?(conf)
        
        let alert = UIAlertController(title: conf.errorLabel, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: conf.agreeLabel, style: .default, handler: nil))
        topmostController.present(alert, animated: true, completion: nil)
    }
    
    public static func textFieldWithTitle(_ title: String, configuration: AlertConfigurationBlock = nil, textFieldConfiguration: ((UITextField) -> Swift.Void)? = nil, agreeAction: ((String) -> ())?) {
        
        let conf = AlertConfiguration()
        configuration?(conf)
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: textFieldConfiguration)
        alert.addAction(UIAlertAction(title: conf.cancelLabel, style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: conf.agreeLabel, style: .default, handler: { action in
        
            if let agreeAction = agreeAction { agreeAction(alert.textFields?.first?.text ?? "") }
        }))
        
        topmostController.present(alert, animated: true, completion: nil)
    }
    
    public static func question(_ message:String, agreeTitle:String, configuration: AlertConfigurationBlock = nil, action: @escaping () -> ()) {
        
        let conf = AlertConfiguration()
        configuration?(conf)
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: conf.cancelLabel, style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: agreeTitle, style: .default, handler: { al in action() }))
        topmostController.present(alert, animated: true, completion: nil)
    }
}

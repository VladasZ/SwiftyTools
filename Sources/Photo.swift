//
//  Photo.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/10/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import Photos
import CoreGraphics
import CoreImage

class Photo : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: - Strings
    
    public static var pickDescription:String = "Add photo"
    public static var pickFromGalleryCaption:String = "Pick from gallery"
    public static var takePhotoCaption:String = "Take a photo"
    public static var cancelCaption:String = "Cancel"
    
    
    public static var askForLibraryPermissionMessage:String = "Application needs access to your photo library."
    public static var askForCameraPermissionMessage:String = "Application needs access to your camera."
    public static var openSettingsTitle:String = "Settings"
    
    private static var completion: ((UIImage) -> ())?
    
    //MARK: - Static elements
    
    public static func get(_ completion:@escaping (UIImage) -> ()) {
        
        if photoDialog == nil { setPhotoDialog() }
        
        topmostController.present(photoDialog!, animated: true, completion: nil)

        self.completion = completion
    }
    
    private static func pick(_ completion:@escaping (UIImage) -> ()) {
        
        checkLibraryPermission {
            
            let controller = Photo()
            
            controller.completion = completion
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func take(_ completion:@escaping (UIImage) -> ()) {
        
        checkCameraPermission {
            
            let controller = Photo()
            
            controller.sourceType = .camera
            
            controller.completion = completion
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func checkLibraryPermission(_ success:@escaping () -> ()) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:          success()
        case .denied, .restricted: self.requestLibraryAccess()
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization() { status in
                
                switch status {
                case .authorized:          success()
                case .denied, .restricted: self.requestLibraryAccess()
                case .notDetermined:       print("notDetermined")
                }
            }
        }
    }
    
    private static func checkCameraPermission(_ success:@escaping () -> ()) {
        
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
            success()
        }
        else {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted :Bool) -> Void in
                if granted == true {
                    success()
                }
                else {
                    requestCameraAccess()
                }
            });
        }
    }
    
    private static func requestLibraryAccess() {
        
        Alert.question(askForLibraryPermissionMessage, agreeTitle: openSettingsTitle) {
            openSettings()
        }
    }
    
    private static func requestCameraAccess() {
        
        Alert.question(askForCameraPermissionMessage, agreeTitle: openSettingsTitle) {
            openSettings()
        }
    }
    
    //MARK: - Variables
    
    private static var photoDialog:UIAlertController?
    
    //MARK: - Controller
    
    private var completion:((UIImage) -> ())?
    
    private var sourceType: UIImagePickerControllerSourceType = .photoLibrary
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIImagePickerController()
        
        picker.sourceType = sourceType
        picker.delegate = self
        
        view.addSubview(picker.view)
        addChildViewController(picker)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        dismiss(animated: true, completion: nil)
        
        completion?(selectedImage)
        completion = nil
    }
    
    //MARK: Dialog
    
    private static func setPhotoDialog() {
        
        photoDialog = UIAlertController(title: pickDescription, message: nil, preferredStyle: .actionSheet)
        
        photoDialog?.addAction(UIAlertAction(title: pickFromGalleryCaption, style: .default) { action in
            
            Photo.pick { image in
                
                Photo.completion?(image)
            }
        })
        
        photoDialog?.addAction(UIAlertAction(title: takePhotoCaption, style: .default) { action in
            
            Photo.take { image in
                
                Photo.completion?(image)
            }
        })
        
//        photoDialog.addAction(UIAlertAction(title: R.string.localization.delete(), style: .destructive) { action in
//            
//        })
        
        photoDialog?.addAction(UIAlertAction(title: cancelCaption, style: .cancel, handler: nil))
    }
}



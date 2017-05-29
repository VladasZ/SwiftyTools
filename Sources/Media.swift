//
//  Media.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/10/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import Photos
import CoreGraphics
import CoreImage

public class Media : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: - Strings
    
    public static var pickDescription: String = "Add media"
    public static var pickPhotoCaption: String = "Pick a photo from gallery"
    public static var takePhotoCaption: String = "Take a photo"
    public static var pickVideoCaption: String = "Pick a video from gallery"
    public static var recordVideoCaption: String = "Take a video"
    public static var cancelCaption: String = "Cancel"
    
    public static var videoEnabled: Bool = false
    
    public static var askForLibraryPermissionMessage: String = "Application needs access to your library."
    public static var askForCameraPermissionMessage: String  = "Application needs access to your camera."
    public static var openSettingsTitle:String = "Settings"
    
    private static var completion: ((UIImage) -> ())?
    
    //MARK: - Static elements
    
    public static func get(_ completion:@escaping (UIImage) -> ()) {
        
        if photoDialog == nil { setMediaDialog() }
        
        topmostController.present(photoDialog!, animated: true, completion: nil)

        self.completion = completion
    }
    
    private static func pickVideo(_ completion:@escaping (UIImage) -> ()) {
        
        checkLibraryPermission {
            
            let controller = Media()
            
            controller.sourceType = .camera
            controller.captureMode = .video
            
            controller.completion = completion
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func recordVideo(_ completion:@escaping (UIImage) -> ()) {
        
        checkLibraryPermission {
            
            let controller = Media()
            
            controller.sourceType = .photoLibrary
            controller.captureMode = .video
            controller.mediaTypes = ["public.movie"]
            
            controller.completion = completion
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func pickPhoto(_ completion:@escaping (UIImage) -> ()) {
        
        checkLibraryPermission {
            
            let controller = Media()
            
            
            controller.sourceType = .photoLibrary
            
            controller.completion = completion
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func takePhoto(_ completion:@escaping (UIImage) -> ()) {
        
        checkCameraPermission {
            
            let controller = Media()
            
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
    private var captureMode: UIImagePickerControllerCameraCaptureMode = .photo
    private var mediaTypes: [String] = [String]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIImagePickerController()
        
//        picker.sourceType = sourceType
//        picker.cameraCaptureMode = captureMode
//        picker.mediaTypes = mediaTypes
//        picker.delegate = self
        
        view.addSubview(picker.view)
        addChildViewController(picker)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        dismiss(animated: true, completion: nil)
        
        completion?(selectedImage)
        completion = nil
    }
    
    //MARK: Dialog
    
    private static func setMediaDialog() {
        
        photoDialog = UIAlertController(title: pickDescription, message: nil, preferredStyle: .actionSheet)
        
        photoDialog?.addAction(UIAlertAction(title: pickPhotoCaption, style: .default) { action in
            
            Media.pickPhoto { image in
                
                Media.completion?(image)
            }
        })
        
        photoDialog?.addAction(UIAlertAction(title: takePhotoCaption, style: .default) { action in
            
            Media.takePhoto { image in
                
                Media.completion?(image)
            }
        })
        
        if videoEnabled {
            
            photoDialog?.addAction(UIAlertAction(title: pickVideoCaption, style: .default) { action in
                
                Media.pickVideo { image in
                    
                    Media.completion?(image)
                }
            })
            
            photoDialog?.addAction(UIAlertAction(title: recordVideoCaption, style: .default) { action in
                
                Media.recordVideo { image in
                    
                    Media.completion?(image)
                }
            })
        }
        
        photoDialog?.addAction(UIAlertAction(title: cancelCaption, style: .cancel, handler: nil))
    }
}



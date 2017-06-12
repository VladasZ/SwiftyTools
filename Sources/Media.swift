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
import MobileCoreServices

public class Media : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: - Strings
    
    public static var pickTitle:String = "Add photo"
    public static var pickImageFromGalleryCaption:String = "Pick image from gallery"
    public static var takePhotoCaption:String = "Take a photo"
    public static var pickVideoFromGalleryCaption:String = "Pick video from gallery"
    public static var recordVideoCaption:String = "Record a video"
    public static var cancelCaption:String = "Cancel"
    
    public static var askForLibraryPermissionMessage:String = "Application needs access to your photo library."
    public static var askForCameraPermissionMessage:String = "Application needs access to your camera."
    public static var openSettingsTitle:String = "Settings"
    
    private static var photoCompletion: ((UIImage) -> ())?
    private static var videoCompletion: ((URL) -> ())?
    private static var universalCompletion: ((UIImage?, URL?) -> ())?
    
    private static var hasVideo: Bool {
        
        return videoCompletion != nil || universalCompletion != nil
    }
    
    private static var hasPhoto: Bool {
        
        return photoCompletion != nil || universalCompletion != nil
    }
    
    private static func clearCompletions() {
        
        photoCompletion = nil
        videoCompletion = nil
        universalCompletion = nil
    }
    
    //MARK: - Properties
    
    var isVideo: Bool = false
    
    //MARK: - Static elements
    
    public static func getVideo(_ completion: @escaping (URL) -> ()) {
        
        videoCompletion = completion
        if photoDialog == nil { setDialog() }
        topmostController.present(photoDialog!, animated: true, completion: nil)
    }
    
    public static func getImage(_ completion: @escaping (UIImage) -> ()) {
        
        photoCompletion = completion
        if photoDialog == nil { setDialog() }
        topmostController.present(photoDialog!, animated: true, completion: nil)
    }
    
    public static func get(_ completion: @escaping (UIImage?, URL?) -> ()) {
        
        universalCompletion = completion
        if photoDialog == nil { setDialog() }
        topmostController.present(photoDialog!, animated: true, completion: nil)
    }
    
    private static func pickVideo() {
        
        checkLibraryPermission {
            let controller = Media()
            controller.isVideo = true            
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func recordVideo() {
        
        checkLibraryPermission {
            let controller = Media()
            controller.isVideo = true
            controller.sourceType = .camera
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func pickPhoto() {
        
        checkLibraryPermission {
            let controller = Media()
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func takePhoto() {
        
        checkCameraPermission {
            let controller = Media()
            controller.sourceType = .camera
            topmostController.present(controller, animated: true)
        }
    }
    
    private static func checkLibraryPermission(_ success: @escaping () -> ()) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:          success()
        case .denied, .restricted: self.requestLibraryAccess()
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization() { status in
                
                switch status {
                case .authorized:          success()
                case .denied, .restricted: self.requestLibraryAccess()
                case .notDetermined:       Log.warning("notDetermined")
                }
            }
        }
    }
    
    private static func checkCameraPermission(_ success: @escaping () -> ()) {
        
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
            success()
        }
        else {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted :Bool) -> Void in
                if granted == true { success() }
                else   { requestCameraAccess() }
            });
        }
    }
    
    private static func requestLibraryAccess() {
        
        Alert.question(askForLibraryPermissionMessage, agreeTitle: openSettingsTitle) { openSettings() }
    }
    
    private static func requestCameraAccess() {
        
        Alert.question(askForCameraPermissionMessage, agreeTitle: openSettingsTitle) { openSettings() }
    }
    
    //MARK: - Variables
    
    private static var photoDialog: UIAlertController!
    
    //MARK: - Controller
    
    private var sourceType: UIImagePickerControllerSourceType = .photoLibrary
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIImagePickerController()
        
        picker.sourceType = sourceType
        picker.delegate = self
        
        if isVideo { picker.mediaTypes = [kUTTypeMovie as String] }
        
        view.addSubview(picker.view)
        addChildViewController(picker)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if !Media.hasPhoto { Log.error() }
            
            dismiss(animated: true, completion: nil)
            
            Media.photoCompletion?(image)
            Media.universalCompletion?(image, nil)
            Media.clearCompletions()
            return
        }
        
        if let videoURL = info[UIImagePickerControllerMediaURL] as? URL {
            
            if !Media.hasVideo { Log.error() }
            
            dismiss(animated: true, completion: nil)
            
            Media.videoCompletion?(videoURL)
            Media.universalCompletion?(nil, videoURL)
            Media.clearCompletions()
            return
        }
        
        Log.error()
    }
    
    //MARK: Dialog
    
    private static func setDialog() {
        
        photoDialog = UIAlertController(title: pickTitle, message: nil, preferredStyle: .actionSheet)
        
        if Media.hasPhoto {
            
            photoDialog.addAction(UIAlertAction(title: pickImageFromGalleryCaption, style: .default) { _ in Media.pickPhoto() })
            photoDialog.addAction(UIAlertAction(title: takePhotoCaption, style: .default)            { _ in Media.takePhoto() })
        }
        
        if Media.hasVideo {
            
            photoDialog.addAction(UIAlertAction(title: pickVideoFromGalleryCaption, style: .default) { _ in Media.pickVideo()   })
            photoDialog.addAction(UIAlertAction(title: recordVideoCaption, style: .default)          { _ in Media.recordVideo() })
        }
        
        photoDialog.addAction(UIAlertAction(title: cancelCaption, style: .cancel, handler: nil))
    }
}



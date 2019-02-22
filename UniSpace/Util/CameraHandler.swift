//
//  CameraHandler.swift
//  UniSpace
//
//  Created by KiKan Ng on 22/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import UIKit
import Photos

class CameraHandler: NSObject {
    static let shared = CameraHandler()

    fileprivate var currentVC: UIViewController!

    //MARK: - Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?

    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            currentVC.present(myPickerController, animated: true, completion: nil)
        }

    }

    func photoLibrary() {

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }

    }

    func showActionSheet(vc: UIViewController, completion: @escaping (_ actionSheet: UIAlertController) -> ()) {
        checkPermission()
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))

        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        completion(actionSheet)
    }

    private func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            log.info("Photo Album Permission", context: "Authorized")
        case .notDetermined:
            log.warning("Photo Album Permission", context: "Not Determined")

            PHPhotoLibrary.requestAuthorization { (status) in
                log.info("Photo Album Permission", context: "Status is \(status)")
            }
        case .restricted:
            log.warning("Photo Album Permission", context: "Restricted")
        case .denied:
            log.warning("Photo Album Permission", context: "Denied")
        }
    }

}


extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            self.imagePickedBlock?(image)
        }else{
            log.warning("Image Picker", context: "Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

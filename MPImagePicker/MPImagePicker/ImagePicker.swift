//
//  ImagePicker.swift
//  Konnek2
//
//  Created by Manish Pandey  on 03/05/18.
//  Copyright © 2017 Aikya. All rights reserved.
//

import UIKit

final class ImagePicker: NSObject {
    let onImagePicked: (UIImage?) -> Void
    
    weak var presentingViewController: UIViewController?
    weak var presentingView: UIView?
    
    init(view: UIView, viewController: UIViewController, onImagePicked: @escaping (UIImage?) -> Void) {
        self.onImagePicked = onImagePicked
        presentingViewController = viewController
        presentingView = view
    }
    
    func showImagePicker() {
        let camera = UIImagePickerController.isSourceTypeAvailable(.camera)
        let library = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        
        if library && camera {
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            sheet.addAction(UIAlertAction(title: "Open Camera", style: .default) {
                [weak self] _ in
                self?.presentImagePicker(sourceType: .camera)
            })
            
            sheet.addAction(UIAlertAction(title: "Open Gallary", style: .default) {
                [weak self] _ in
                self?.presentImagePicker(sourceType: .photoLibrary)
            })
            
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            presentingViewController?.present(sheet, animated: true, completion: nil)
        } else if camera {
            presentImagePicker(sourceType: .camera)
        } else if library {
            presentImagePicker(sourceType: .photoLibrary)
        }
    }
    
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        if let presentingView = presentingView, let presentingViewController = presentingViewController {
            let camera = UIImagePickerController()
            camera.sourceType = sourceType
            camera.delegate = self
            camera.allowsEditing = true
            
            if sourceType == .photoLibrary {
                // Documentation says picking from photo library on iPad must use popover.
                if let popover = camera.popoverPresentationController {
                    camera.modalPresentationStyle = .popover
                    
                    popover.permittedArrowDirections = .any
                    popover.sourceView = presentingView
                    popover.sourceRect = presentingView.frame
                }
            } else if sourceType == .camera && UIImagePickerController.isCameraDeviceAvailable(.front) {
                camera.cameraDevice = .front
            }
            
            presentingViewController.present(camera, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ImagePicker: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = (info[UIImagePickerController.InfoKey.editedImage] ?? info[UIImagePickerController.InfoKey.originalImage]) as! UIImage
        presentingViewController?.dismiss(animated: true, completion: nil)
        onImagePicked(image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        presentingViewController?.dismiss(animated: true, completion: nil)
        onImagePicked(nil)
    }
}


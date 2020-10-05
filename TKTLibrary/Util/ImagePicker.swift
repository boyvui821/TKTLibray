//
//  ImagePicker.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/29/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

class ImagePicker: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    static let shared = ImagePicker()
    
    var imagePicker = UIImagePickerController()
    
    var complete: ((UIImage?)->Void) = {_ in}
    
    func show(sourceView: UIView? = nil, complete: @escaping ((UIImage?)->Void)) {
        self.complete = complete
        guard let topVC = UIApplication.topViewController() else { return }
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .fullScreen
        topVC.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as? UIImage
        complete(image)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage
//        complete(image)
//    }
    
}

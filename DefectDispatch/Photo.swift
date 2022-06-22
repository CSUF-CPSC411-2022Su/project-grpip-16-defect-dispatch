//
//  Photo.swift
//  DefectDispatch
//
//  Created by Jed Verry on 6/8/22.
//

import Foundation
import UIKit

class Photo: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePicked: UIImageView!
    

    @IBAction func openLibrary(sender: AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}



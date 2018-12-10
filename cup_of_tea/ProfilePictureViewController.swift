//
//  ProfilePictureViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/1/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import FirebaseStorage

class ProfilePictureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var selectedImage: UIImage? = nil
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBAction func chooseFromAlbumPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
       
        
        let sv = UIViewController.displaySpinner(onView: self.view)

        let storageRef = Storage.storage().reference()
        
        // Data in memory
        var data = NSData()
        data = selectedImage.jpegData(compressionQuality: 0.03)! as NSData
        let userId = UserProfile.sharedInstance.userId
        // Create a reference to the file you want to upload
        let docRef = storageRef.child("profiles_ios/\(userId).jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        _ = docRef.putData(data as Data, metadata: nil) { (metadata, error) in

           
            docRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    self.profileImageView.image = selectedImage
                    let alert = UIAlertController(title: "Failed to upload image", message: "Possible reason: no Internet, our database is down.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                 UIViewController.removeSpinner(spinner: sv)
                self.profileImageView.image = selectedImage
                UserProfile.sharedInstance.profile_pic_url = "\(downloadURL)"
            }
        }
        
       
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
}

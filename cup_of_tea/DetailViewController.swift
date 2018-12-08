//
//  DetailViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 11/28/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    
    let PROFILE_PICTURE_HEIGHT = 200
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    var index = 0
    var detail: Dictionary<String, Any> = [:]
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if profilePic != nil {
            if UIDevice.current.orientation.isLandscape {
                print("Landscape")
                imgHeightConstraint.constant = 0
//                profilePic.isHidden = true
                
//                let screenSize: CGRect = UIScreen.main.bounds
//                profilePic.frame = CGRect(x: 0, y: 0, width: 200, height: 40.0)
//                profilePic.image = resizeImage(image: profilePic.image!, targetSize: CGSize(width: 200, height: 1))
//                profilePic.image = resizeImage(image: profilePic.image!, targetSize: CGSize(width: 1, height: 1))
            } else {
                imgHeightConstraint.constant = 254
//                profilePic.isHidden = false
//                if let imagefromCache = MasterViewController.imageCache.object(forKey: detail["profile_picture"] as AnyObject) as? UIImage
//                {
//                     profilePic.image = resizeImage(image: imagefromCache, targetSize: CGSize(width: 300, height: 300))
//
//                }
               
                print("Portrait")
            }
        }
        
    }
    
//    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//        let size = image.size
//
//        let widthRatio  = targetSize.width  / size.width
//        let heightRatio = targetSize.height / size.height
//
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//        }
//
//        // This is the rect that we've calculated out and this is what is actually used below
//        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//
//        // Actually do the resizing to the rect using the ImageContext stuff
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        image.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
    
    func configureView() {
//        print(detailItem)
        print(imgHeightConstraint)
        if detailItem != nil && firstNameLabel != nil {
            detail = detailItem as! Dictionary<String, Any>
            
            firstNameLabel.text = detail["first_name"] as? String
            if let imagefromCache = MasterViewController.imageCache.object(forKey: detail["profile_picture"] as AnyObject) as? UIImage
            {
                profilePic.image = imagefromCache
            } else {
                profilePic.image = UIImage(named: "profile_picture_placeholder")
            }
//            if UIDevice.current.orientation.isLandscape {
//                print("Landscape1")
////                profilePic.isHidden = true
//
//                profilePic.image = resizeImage(image:  profilePic.image!, targetSize: CGSize(width: 1, height: 1))
//            } else {
//                if let imagefromCache = MasterViewController.imageCache.object(forKey: detail["profile_picture"] as AnyObject) as? UIImage
//                {
//
//                    profilePic.image = resizeImage(image: imagefromCache, targetSize: CGSize(width: 300, height: 300))
//
//
//
//                }
//
//                }
            
            }
        }
        
   
        
//    func setProfileImg() {
//        if detailItem != nil && profilePic != nil {
//            detail = detailItem as! Dictionary<String, Any>
//
//            if UIDevice.current.orientation.isLandscape {
//                profilePic.image = resizeImage(image:  profilePic.image!, targetSize: CGSize(width: 1, height: 1))
//                profilePic.isHidden = true
//
//            } else {
//                if let imagefromCache = MasterViewController.imageCache.object(forKey: detail["profile_picture"] as AnyObject) as? UIImage
//                {
//                    profilePic.image = imagefromCache
//
//                } else {
//                    profilePic.image = UIImage(named: "profile_picture_placeholder")
//                }
//                profilePic.isHidden = true
//
//            }
//
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Any? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}


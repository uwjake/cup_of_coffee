//
//  DetailViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 11/28/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    var index = 0
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if profilePic != nil {
            if UIDevice.current.orientation.isLandscape {
                print("Landscape")
//                profilePic.isHidden = true
                
                let screenSize: CGRect = UIScreen.main.bounds
//                profilePic.frame = CGRect(x: 0, y: 0, width: 200, height: 40.0)
                profilePic.image = resizeImage(image: profilePic.image!, targetSize: CGSize(width: 200, height: 20))
            } else {
//                profilePic.isHidden = false
               profilePic.image = resizeImage(image: profilePic.image!, targetSize: CGSize(width: 200, height: 200))
                print("Portrait")
            }
        }
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func configureView() {
//        print(detailItem)
        
        if detailItem != nil && firstNameLabel != nil {
            let detail = detailItem as! Dictionary<String, Any>
            
            firstNameLabel.text = detail["first_name"] as? String
            
            if UIDevice.current.orientation.isLandscape {
                print("Landscape1")
//                profilePic.isHidden = true
                profilePic.image = resizeImage(image: profilePic.image!, targetSize: CGSize(width: 200, height: 20))
            } else {
                print("Portrait")
                profilePic.image = resizeImage(image: profilePic.image!, targetSize: CGSize(width: 200, height: 200))
            }
        }
        
       
        
        // Update the user interface for the detail item.
//        if let detail = detailItem {
//            if let label = detailDescriptionLabel {
//                label.text = (detail as AnyObject).description
//            }
//        }
//        detailDescriptionLabel.text = detail["first_name"] as? String
//
    }

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


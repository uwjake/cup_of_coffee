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
    
    let PROFILE_PICTURE_HEIGHT = 254
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    var index = 0
    var detail: Dictionary<String, Any> = [:]
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if profilePic != nil {
            setProfilePicHeight()
        }
        
    }
    
    func setProfilePicHeight() {
        if UIDevice.current.orientation.isLandscape {
            profilePic.isHidden = true
            imgHeightConstraint.constant = 0
        } else {
            profilePic.isHidden = false
            imgHeightConstraint.constant = CGFloat(PROFILE_PICTURE_HEIGHT)
        }

    }
    
    func configureView() {

        if detailItem != nil && firstNameLabel != nil {
            detail = detailItem as! Dictionary<String, Any>
            
            firstNameLabel.text = detail["first_name"] as? String
            
            if let imagefromCache = MasterViewController.imageCache.object(forKey: detail["profile_picture"] as AnyObject) as? UIImage
            {
                profilePic.image = imagefromCache
            } else {
                profilePic.image = UIImage(named: "profile_picture_placeholder")
            }
            
            setProfilePicHeight()
            
            }
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


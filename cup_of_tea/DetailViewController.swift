//
//  DetailViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 11/28/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import MessageUI
import MapKit

class DetailViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    
    let PROFILE_PICTURE_HEIGHT = 254
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var genderPic: UIImageView!
    @IBOutlet weak var interestsLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var connectButton: UIButton!
    
    @IBAction func connectButton(_ sender: UIButton) {
        let contactType = detail["contact_type"] as! String
        if contactType == "EMAIL" {
            let email = detail["contact_value"] as! String
            let url = URL(string: "mailto:\(email)")
            UIApplication.shared.open(url!)
        } else if contactType == "PHONE" {
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                controller.body = "Message Body"
                controller.recipients = ["234234"]
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    @IBAction func navigateButton(_ sender: UIButton) {
        let coordinate = CLLocationCoordinate2DMake(123,-45)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
    }
    
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
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    func configureView() {

        if detailItem != nil && firstNameLabel != nil {
            detail = detailItem as! Dictionary<String, Any>
            let firstName = detail["first_name"] as! String
            let lastName = detail["last_name"] as! String
            if lastName == "" {
                 firstNameLabel.text = detail["first_name"] as? String
            } else {
                 firstNameLabel.text = "\(firstName) \(lastName)"
            }
            
            genderPic.image = UIImage(named: detail["gender"] as! String)
           
            summaryLabel.text = detail["summary"] as? String
            ageLabel.text = "Age: \(detail["age"] as? Int ?? 0)"
            interestsLabel.text = "Interests: " + (detail["interests"] as? String ?? "")

            if let imagefromCache = MasterViewController.imageCache.object(forKey: detail["profile_picture"] as AnyObject) as? UIImage
            {
                profilePic.image = imagefromCache
            } else {
                profilePic.image = UIImage(named: "profile_picture_placeholder")
            }
            
            let contactType = detail["contact_type"] as! String
            if contactType == "EMAIL" {
                connectButton.setTitle("Connect via Email", for: .normal)
            } else if contactType == "PHONE" {
                connectButton.setTitle("Connect via SMS", for: .normal)
            } else {
                connectButton.isHidden = true
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


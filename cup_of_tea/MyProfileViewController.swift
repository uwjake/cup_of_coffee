//
//  MyProfileViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/8/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myContact = UserDefaults.standard.string(forKey: "my_contact") ?? UserProfile.sharedInstance.userId
        loadData()
    }
    var myProfileData: Dictionary<String, Any> = [:]
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderPic: UIImageView!
    @IBOutlet weak var genderPrefPic: UIImageView!
    @IBOutlet weak var interestsLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    var myContact = ""
    
    @IBAction func onLocationShareSwitchChanged(_ sender: UISwitch) {
        let db = Firestore.firestore()
        let isON = sender.isOn
        DispatchQueue.main.async {
            db.collection("users").document(self.myContact).updateData([
                "location_visible": isON
            ]) { err in
                if err != nil {
//                    print("Error updating document: \(err)")
                    self.presentAlert("Error", "Location sharing not updated, please try again later.")
                } else {
                    //                    print("Document successfully updated")
//                    var message = "Now your location is hidden from people."
//                    if isON {
//                        message = "Now people can see your location"
//                    }
//                    self.presentAlert("Location sharing setting updated", message)
                }
            }
        }
    }
    @IBAction func resetProfile(_ sender: UIButton) {
        let alert = UIAlertController(title: "Start over", message: "You sure want to start over?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel, handler: goToGetStarted))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToGetStarted(alert: UIAlertAction!) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GetStartedViewController")
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func loadData() {
        //        print("start loading")
        DispatchQueue.main.async {
            let db = Firestore.firestore()
            let settings = db.settings
            settings.areTimestampsInSnapshotsEnabled = true
            db.settings = settings
            
//            print(UserDefaults.standard.value(forKey: "my_contact") ?? "")
            

//                print("My contact", myContact)
       
            let docRef = db.collection("users").document(self.myContact)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.myProfileData = document.data() as! Dictionary<String, Any>
                    UserProfile.sharedInstance.myProfileData = self.myProfileData
                    self.setUpMyProfile()
                } else {
                    self.presentAlert("Profile not found", "Cannot find your contact method in our database. Please try reseting your profile.")
                }
            }
        }
    }
    
    func setUpMyProfile() {
        if profilePic != nil {
            nameLabel.text = "\(myProfileData["first_name"] ?? "") \(myProfileData["last_name"] ?? "")"
            let summaryText = (myProfileData["summary"] ?? "no summary") as! String
            if summaryText == "" {
                summaryLabel.text = "No Intro"
            } else {
                summaryLabel.text = summaryText
            }
            
            let date = NSDate(timeIntervalSince1970: TimeInterval((self.myProfileData["dob"] as! Timestamp).seconds))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "YYYY-MM-dd"
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            dobLabel.text = "Dob: \(dateString)"
            genderPic.image = UIImage(named: self.myProfileData["gender"] as! String)
            genderPrefPic.image = UIImage(named: self.myProfileData["gender_pref"] as! String)
            interestsLabel.text = "Interests: \(self.myProfileData["interests"] as! String)"
            contactLabel.text = "Contact: \((self.myProfileData["contact_type"] as! String).lowercased()) \(self.myProfileData["userId"] as! String)"
            
            let url = self.myProfileData["profile_picture"] as! String
            
            if url != ""
            {
                if let imagefromCache = MasterViewController.imageCache.object(forKey: url as AnyObject) as? UIImage
                {
                    profilePic.image = imagefromCache
                    
                } else {
                    profilePic.image = nil
                    
                    
                    let urlURL = URL(string: (url))
                    if urlURL != nil {
                        
                        URLSession.shared.dataTask(with: urlURL!, completionHandler: { (data, response, error) in
                            if error != nil
                            {
                                //                        print(error.debugDescription)
                                return
                            }
                            
                            DispatchQueue.main.async {
                                let imagetoCache = UIImage(data:data!)
                                if imagetoCache != nil {
                                    MasterViewController.imageCache.setObject(imagetoCache!, forKey: url as AnyObject)
                                    self.profilePic.image = imagetoCache
                                    
                                } else {
                                    //                                    print("url failed")
//                                    profilePicimage = UIImage(named: "profile_picture_placeholder")
                                }
                            }
                        }).resume()
                    }
                }
            } else {
                //                print("no profile picimgage")
//                profilePic.image = UIImage(named: "profile_picture_placeholder")
            }
        }
    }
    
    func getAgeFromTimestamp(dob: Timestamp)->Int {
        let today = Int64(NSDate().timeIntervalSince1970)
        let age = Int ( (today - dob.seconds) / (60*60*24*365) )
        return age
    }
    
    func presentAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

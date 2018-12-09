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
        loadData()
        // Do any additional setup after loading the view.
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
    @IBAction func resetProfile(_ sender: UIButton) {
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
            
            print(UserDefaults.standard.value(forKey: "my_contact") ?? "")
            let myContact = UserDefaults.standard.string(forKey: "my_contact") ?? ""

//                print("My contact", myContact)
       
            let docRef = db.collection("users").document(myContact)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.myProfileData = document.data() as! Dictionary<String, Any>
                    self.setUpMyProfile()
                } else {
                    self.presentError()
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
            dobLabel.text = dateString
            genderPic.image = UIImage(named: self.myProfileData["gender"] as! String)
            genderPrefPic.image = UIImage(named: self.myProfileData["gender_pref"] as! String)
            interestsLabel.text = (self.myProfileData["interests"] as! String)
            contactLabel.text = "\((self.myProfileData["contact_type"] as! String).lowercased()) \(self.myProfileData["userId"] as! String)"
        }
    }
    
    func getAgeFromTimestamp(dob: Timestamp)->Int {
        let today = Int64(NSDate().timeIntervalSince1970)
        let age = Int ( (today - dob.seconds) / (60*60*24*365) )
        return age
    }
    
    func presentError() {
        let alert = UIAlertController(title: "Profile not found", message: "Cannot find your contact method in our database. Please try reseting your profile.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

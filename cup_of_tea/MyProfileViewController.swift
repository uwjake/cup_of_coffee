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
    
    func loadData() {
        
        //        print("start loading")
        DispatchQueue.main.async
            {
                let db = Firestore.firestore()
                let settings = db.settings
                settings.areTimestampsInSnapshotsEnabled = true
                db.settings = settings
                
                if  let array = UserDefaults.standard.object(forKey:"my_contact") as? String {
                        print("asr", array)
                }
        
                let myContact = "asdf"
                print(UserDefaults.standard.object(forKey: "my_contact"))
                
                if myContact != nil || myContact != "" {
                    print("My contact", myContact)
               
                    let docRef = db.collection("users").document(myContact ?? "d")
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.myProfileData = document.data() as! Dictionary<String, Any>
                        print(self.myProfileData)
                    } else {
                        self.presentError()
                    }
                }
                    
                } else {
                   self.presentError()
                }

                
              
        }
        //        print("done loading")
        
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

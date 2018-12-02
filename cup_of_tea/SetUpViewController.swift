//
//  SetUpViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 11/28/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

//import FirebaseCore
class SetUpViewController: UIViewController {
    
    var FEMALE = "female"
    var MALE = "male"

    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var femaleLabel: UILabel!
    
    @IBOutlet weak var maleLabel: UILabel!
    
    @IBAction func femaleBtnPressed(_ sender: Any) {
        maleLabel.textColor = UIColor.black
        femaleLabel.textColor = UIColor.orange
        UserProfile.sharedInstance.gender = FEMALE
    }
    
    @IBAction func maleBtnPressed(_ sender: Any) {
        femaleLabel.textColor = UIColor.black
        maleLabel.textColor = UIColor.orange
        UserProfile.sharedInstance.gender = MALE
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNext.layer.cornerRadius = 25
        
//        let db = Firestore.firestore()
//        let settings = db.settings
//        settings.areTimestampsInSnapshotsEnabled = true
//        db.settings = settings
//
//        db.collection("users").document("one").getDocument() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
////                for document in querySnapshot!.documents {
////                    print("\(document.documentID) => \(document.data())")
////                }
//                print(querySnapshot!.documentID)
//                print(querySnapshot!.data())
//            }
//        }
        
        
        // Do any additional setup after loading the view.
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

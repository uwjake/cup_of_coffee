//
//  SetUpViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 11/28/18./Users/liuqingma/Dropbox/info449/final-project/cup_of_coffee/cup_of_tea/SetUpViewController.swift
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
    @IBOutlet weak var bt_female: UIButton!
    @IBOutlet weak var bt_male: UIButton!
    
    @IBAction func femaleBtnPressed(_ sender: Any) {
        
        
        bt_female.setBackgroundImage(UIImage(named:"bt_female_selected"), for: .normal)
        bt_male.setBackgroundImage(UIImage(named:"bt_male"), for: .normal)
        
        UserProfile.sharedInstance.gender = FEMALE
    }
    
    @IBAction func maleBtnPressed(_ sender: Any) {
        bt_female.setBackgroundImage(UIImage(named:"bt_female"), for: .normal)
        bt_male.setBackgroundImage(UIImage(named:"bt_male_selected"), for: .normal)
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

//
//  MyProfileViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/8/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MyProfileViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
        var myProfileData: Dictionary<String, Any> = [:]
        //        print("start loading")
        DispatchQueue.main.async
            {
                let db = Firestore.firestore()
                let settings = db.settings
                settings.areTimestampsInSnapshotsEnabled = true
                db.settings = settings
                
                let docRef = db.collection("cities").document("SF")
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        myProfileData = document.data() as! Dictionary<String, Any>
                        
                        print(myProfileData)
                    } else {
                        print("Document does not exist")
                    }
                }

                
              
        }
        //        print("done loading")
        
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

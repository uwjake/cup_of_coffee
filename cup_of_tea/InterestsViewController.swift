//
//  InterestsViewController.swift
//  cup_of_tea
//
//  Created by Liuqing Ma on 12/5/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class InterestsViewController: UIViewController {

    @IBOutlet weak var btnCheckBox1: UIButton!
    @IBOutlet weak var btnCheckBox2: UIButton!
    @IBOutlet weak var btnCheckBox3: UIButton!
    @IBOutlet weak var btnCheckBox4: UIButton!
    @IBOutlet weak var btnCheckBox5: UIButton!
    @IBOutlet weak var btnCheckBox6: UIButton!
    let interestsList : Array<String> = ["Hiking", "Movie", "Eating", "Gaming", "Cuddling", "Cooking"]
    var userInstance = UserProfile.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnCheckBox(btnCheckBox: btnCheckBox1);
        setupBtnCheckBox(btnCheckBox: btnCheckBox2);
        setupBtnCheckBox(btnCheckBox: btnCheckBox3);
        setupBtnCheckBox(btnCheckBox: btnCheckBox4);
        setupBtnCheckBox(btnCheckBox: btnCheckBox5);
        setupBtnCheckBox(btnCheckBox: btnCheckBox6);
        print("user gender: \(UserProfile.sharedInstance.gender)")
        print("user gender pref: \(UserProfile.sharedInstance.gender_pref)")
        print("data", UserProfile.sharedInstance)
    }
    
    func setupBtnCheckBox(btnCheckBox : UIButton!) {
        btnCheckBox.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        btnCheckBox.setImage(UIImage(named:"Checkmark"), for: .selected)
    }
    
    @IBAction func checkBox1Pressed(_ sender: Any) {
        if (userInstance.interests.contains(interestsList[0])) {
            userInstance.interests.remove(interestsList[0])
        } else {
            userInstance.interests.insert(interestsList[0])
        }
    }
    
    @IBAction func checkBox2Pressed(_ sender: Any) {
        if (userInstance.interests.contains(interestsList[1])) {
            userInstance.interests.remove(interestsList[1])
        } else {
            userInstance.interests.insert(interestsList[1])
        }
    }

    @IBAction func checkBox3Pressed(_ sender: Any) {
        if (userInstance.interests.contains(interestsList[2])) {
            userInstance.interests.remove(interestsList[2])
        } else {
            userInstance.interests.insert(interestsList[2])
        }
    }

    @IBAction func checkBox4Pressed(_ sender: Any) {
        if (userInstance.interests.contains(interestsList[3])) {
            userInstance.interests.remove(interestsList[3])
        } else {
            userInstance.interests.insert(interestsList[3])
        }
    }

    @IBAction func checkBox5Pressed(_ sender: Any) {
        if (userInstance.interests.contains(interestsList[4])) {
            userInstance.interests.remove(interestsList[4])
        } else {
            userInstance.interests.insert(interestsList[4])
        }
    }

    @IBAction func checkBox6Pressed(_ sender: Any) {
        if (userInstance.interests.contains(interestsList[5])) {
            userInstance.interests.remove(interestsList[5])
        } else {
            userInstance.interests.insert(interestsList[5])
        }
    }
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        uploadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- checkMarkTapped
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.05, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.2, delay: 0.05, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        print("User interests: \(UserProfile.sharedInstance.interests)")
    }
    
    func uploadData() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        let docData: [String: Any] = [
            "contact_type": userInstance.contact_type,
            "userId": userInstance.userId,
            "first_name": userInstance.firstName,
            "last_name": userInstance.lastName,
            "summary": userInstance.summary,
            "gender": userInstance.gender,
            "gender_pref": userInstance.gender_pref,
            "dob": userInstance.dob,
            "interests": setToString(set: userInstance.interests),
            "profile_picture": userInstance.profile_pic_url,
            "location": [
                "lat": userInstance.lat,
                "lng": userInstance.lng
            ]
        ]
        db.collection("users").document(userInstance.userId).setData(docData) { err in
            if let err = err {
                let alert = UIAlertController(title: "Failed to load data", message: "Possible reason: no Internet, our database is down.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Error writing document: \(err)")
            } else {
                UserDefaults.standard.set(true, forKey: "set_up")
                UserDefaults.standard.set(UserProfile.sharedInstance.userId, forKey: "my_contact")
                UIViewController.removeSpinner(spinner: sv)
                self.goToList()
                print("Document successfully written!")
                
            }
        }
    }
    
    func goToList() {
        performSegue(withIdentifier: "setUpDone", sender:self)
    }
    
    func setToString(set : Set<String>) -> String {
        let array = Array(set)
        let result : String = array.joined(separator: ", ")
        return result
    }
}

extension UIViewController {
class func displaySpinner(onView : UIView) -> UIView {
    let spinnerView = UIView.init(frame: onView.bounds)
    spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    let ai = UIActivityIndicatorView.init(style: .whiteLarge)
    ai.startAnimating()
    ai.center = spinnerView.center
    
    DispatchQueue.main.async {
        spinnerView.addSubview(ai)
        onView.addSubview(spinnerView)
    }
    
    return spinnerView
}

class func removeSpinner(spinner :UIView) {
    DispatchQueue.main.async {
        spinner.removeFromSuperview()
    }
}
}

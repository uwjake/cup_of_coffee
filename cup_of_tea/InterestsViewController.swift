//
//  InterestsViewController.swift
//  cup_of_tea
//
//  Created by Liuqing Ma on 12/5/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController {

    @IBOutlet weak var btnCheckBox1: UIButton!
    @IBOutlet weak var btnCheckBox2: UIButton!
    @IBOutlet weak var btnCheckBox3: UIButton!
    @IBOutlet weak var btnCheckBox4: UIButton!
    @IBOutlet weak var btnCheckBox5: UIButton!
    @IBOutlet weak var btnCheckBox6: UIButton!
    let interestsList : Array<String> = ["Hiking", "Movie", "Eating", "Gaming", "Cudding", "Cooking"]
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}

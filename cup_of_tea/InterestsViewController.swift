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
    var userInterests = UserProfile.sharedInstance.interests
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnCheckBox(btnCheckBox: btnCheckBox1);
        setupBtnCheckBox(btnCheckBox: btnCheckBox2);
        setupBtnCheckBox(btnCheckBox: btnCheckBox3);
        setupBtnCheckBox(btnCheckBox: btnCheckBox4);
        setupBtnCheckBox(btnCheckBox: btnCheckBox5);
        setupBtnCheckBox(btnCheckBox: btnCheckBox6);
    }
    
    func setupBtnCheckBox(btnCheckBox : UIButton!) {
        btnCheckBox.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        btnCheckBox.setImage(UIImage(named:"Checkmark"), for: .selected)
    }
    
    @IBAction func checkBox1Pressed(_ sender: Any) {
        if (userInterests.contains(interestsList[0])) {
            userInterests.remove(interestsList[0])
        } else {
            userInterests.insert(interestsList[0])
        }
    }
    
    @IBAction func checkBox2Pressed(_ sender: Any) {
        if (userInterests.contains(interestsList[1])) {
            userInterests.remove(interestsList[1])
        } else {
            userInterests.insert(interestsList[1])
        }
    }


    @IBAction func checkBox3Pressed(_ sender: Any) {
        if (userInterests.contains(interestsList[2])) {
            userInterests.remove(interestsList[2])
        } else {
            userInterests.insert(interestsList[2])
        }
    }

    @IBAction func checkBox4Pressed(_ sender: Any) {
        if (userInterests.contains(interestsList[3])) {
            userInterests.remove(interestsList[3])
        } else {
            userInterests.insert(interestsList[3])
        }
    }

    @IBAction func checkBox5Pressed(_ sender: Any) {
        if (userInterests.contains(interestsList[4])) {
            userInterests.remove(interestsList[4])
        } else {
            userInterests.insert(interestsList[4])
        }
    }

    @IBAction func checkBox6Pressed(_ sender: Any) {
        if (userInterests.contains(interestsList[5])) {
            userInterests.remove(interestsList[5])
        } else {
            userInterests.insert(interestsList[5])
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
        print(userInterests)
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

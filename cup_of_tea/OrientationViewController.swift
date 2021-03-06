//
//  OrientationViewController.swift
//  cup_of_tea
//
//  Created by Liuqing Ma on 11/30/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class OrientationViewController: UIViewController {
    
    var FEMALE = "female"
    var MALE = "male"
    var userInstance = UserProfile.sharedInstance
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var bt_female: UIButton!
    @IBOutlet weak var bt_male: UIButton!
    
    @IBAction func femaleBtnPressed(_ sender: Any) {
        bt_female.setBackgroundImage(UIImage(named:"bt_female_selected"), for: .normal)
        bt_male.setBackgroundImage(UIImage(named:"bt_male"), for: .normal)
        userInstance.gender_pref = FEMALE
    }
    
    @IBAction func maleBtnPressed(_ sender: Any) {
        bt_female.setBackgroundImage(UIImage(named:"bt_female"), for: .normal)
        bt_male.setBackgroundImage(UIImage(named:"bt_male_selected"), for: .normal)
        userInstance.gender_pref = MALE
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

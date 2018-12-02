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
    
    @IBOutlet weak var nextBtn: UIButton!
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
        nextBtn.layer.cornerRadius = 25
        
        print(UserProfile.sharedInstance.firstName)
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

//
//  NameViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/1/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    var originalButtonColor: UIColor? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        originalButtonColor = nextButton.backgroundColor ?? UIColor.orange
        nextButton.backgroundColor = UIColor.gray
        
        print("loc", UserProfile.sharedInstance.lat,  UserProfile.sharedInstance.lng)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func firstNameTextfield(_ sender: UITextField) {
        UserProfile.sharedInstance.firstName = sender.text ?? ""
        if sender.text ?? "" == "" {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.gray
        } else {
            nextButton.isEnabled = true
            nextButton.backgroundColor = originalButtonColor
        }
    }
    
    @IBAction func lastNameTextField(_ sender: UITextField) {
        UserProfile.sharedInstance.lastName = sender.text ?? ""
    }
    
    @IBAction func ageTextField(_ sender: UITextField) {
        UserProfile.sharedInstance.summary = sender.text ?? ""
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

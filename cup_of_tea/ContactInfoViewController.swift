//
//  ContactInfoViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/8/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {
    
    @IBOutlet weak var phoneTextView: UITextField!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    var DEFAULT_PHONE = "2061582345"
    var DEFAULT_EMAIL = "shwih@gmail.com"
    var userInstance = UserProfile.sharedInstance
    var phonePressed = false
    var emailPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnCheckBox(btnCheckBox: phoneBtn);
        setupBtnCheckBox(btnCheckBox: emailBtn);
    }
    
    func setupBtnCheckBox(btnCheckBox : UIButton!) {
        btnCheckBox.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
        enable(btnCheckBox: phoneBtn)
        phonePressed = true
        disable(btnCheckBox: emailBtn)
        emailPressed = false
        userInstance.contact_type = "PHONE"
    }
    
    @IBAction func emailBtnPressed(_ sender: Any) {
        enable(btnCheckBox: emailBtn)
        emailPressed = true
        disable(btnCheckBox: phoneBtn)
        phonePressed = false
        userInstance.contact_type = "EMAIL"
    }
    
    func enable(btnCheckBox : UIButton!) {
        btnCheckBox.setImage(UIImage(named:"Checkmark"), for: .normal)
    }
    
    func disable(btnCheckBox : UIButton!) {
        btnCheckBox.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if (phonePressed) {
            if (phoneTextView.text == "") {
                userInstance.userId = DEFAULT_PHONE
            } else {
                userInstance.userId = phoneTextView.text!
            }
        } else {
            if (emailTextView.text == "") {
                userInstance.userId = DEFAULT_EMAIL
            } else {
                userInstance.userId = emailTextView.text!
            }
        }
        print("user first name: \(UserProfile.sharedInstance.firstName)")
        print("user last name: \(UserProfile.sharedInstance.lastName)")
        print("user contact type: \(UserProfile.sharedInstance.contact_type)")
        print("user contact: \(UserProfile.sharedInstance.userId)")
    }
    
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.05, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.2, delay: 0.05, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
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

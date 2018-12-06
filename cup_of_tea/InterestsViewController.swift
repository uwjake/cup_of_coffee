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
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.layer.cornerRadius = 25

        // Do any additional setup after loading the view.
        btnCheckBox1.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        btnCheckBox1.setImage(UIImage(named:"Checkmark"), for: .selected)
        
        btnCheckBox2.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        btnCheckBox2.setImage(UIImage(named:"Checkmark"), for: .selected)
        
        btnCheckBox3.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        btnCheckBox3.setImage(UIImage(named:"Checkmark"), for: .selected)
        
        btnCheckBox4.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        btnCheckBox4.setImage(UIImage(named:"Checkmark"), for: .selected)
        
        btnCheckBox5.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        btnCheckBox5.setImage(UIImage(named:"Checkmark"), for: .selected)
        
        btnCheckBox6.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        btnCheckBox6.setImage(UIImage(named:"Checkmark"), for: .selected)
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

//
//  GetStartedViewController.swift
//  cup_of_tea
//
//  Created by Liuqing Ma on 11/30/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedBtn.layer.cornerRadius = 30
    }
    
    @IBOutlet weak var getStartedBtn: UIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

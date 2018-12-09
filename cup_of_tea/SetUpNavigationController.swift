//
//  SetUpNavigationController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/8/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class SetUpNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

}

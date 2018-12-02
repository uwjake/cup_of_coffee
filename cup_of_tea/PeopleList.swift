//
//  PeopleList.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/1/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
//import FirebaseFirestore

class PeopleList: NSObject {
    static let sharedInstance = UserProfile()
    
    var firstName = ""
    var lastName = ""
    var gender = ""
    var gender_pref = ""
    var age:Int? = nil
    var profile_pic_url = ""
    
   
}

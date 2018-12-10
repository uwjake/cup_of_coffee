//
//  UserProfile.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/1/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class UserProfile: NSObject {
   
    static let sharedInstance = UserProfile()
    
    
    var firstName = ""
    var lastName = ""
    var lat: Double = 0
    var lng: Double = 0
    var contact_type = "PHONE"
    var userId = ""
    var gender = "other"
    var gender_pref = "other"
    var summary: String = ""
    var dob: Date = Date()
    var profile_pic_url = ""
    var interests : Set = Set<String>()
    var peopleList:[Dictionary<String, Any>] = []
    var myProfileData:Dictionary<String, Any> = [:]
}

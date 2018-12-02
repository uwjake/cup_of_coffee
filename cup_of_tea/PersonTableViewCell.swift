//
//  PersonTableViewCell.swift
//  cup_of_tea
//
//  Created by Jake Jin on 12/1/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

//
//  CustomFotterCell.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 05/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit

class CustomFotterCell: UITableViewCell {
    
    //Custom cell which our footer cell
    
    
    @IBOutlet weak var labelUserName: UILabel!
    
    
    @IBOutlet weak var buttonPost: UIButton!
    
    
    @IBOutlet weak var footerImage: UIImageView!
    
    @IBOutlet weak var labelComments: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

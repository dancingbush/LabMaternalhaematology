//
//  CasesTableViewCell.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 30/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit

class CasesTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imageLeft: UIImageView!
    
    
    @IBOutlet weak var labelScore: UILabel!
    //@IBOutlet weak var labelCaseNumber: UIView!
    
    @IBOutlet weak var labelCaseNo: UILabel!
    
    @IBOutlet weak var labelTop: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

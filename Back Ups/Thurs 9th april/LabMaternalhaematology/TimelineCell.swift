//
//  TimelineCell.swift
//  Mega
//
//  Created by Tope Abayomi on 19/11/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

import Foundation
import UIKit

class TimelineCell : UITableViewCell {
    
    @IBOutlet var typeImageView : UIImageView!
    @IBOutlet var profileImageView : UIImageView!
    @IBOutlet var dateImageView : UIImageView!
    @IBOutlet var photoImageView : UIImageView?
    
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var postLabel : UILabel?
    @IBOutlet var dateLabel : UILabel!

    override func awakeFromNib() {
        
        dateImageView.image = UIImage(named: "clock")
        dateImageView.alpha = 0.20
        profileImageView.layer.cornerRadius = 30
        
        nameLabel.font = UIFont(name: TuneUpTheme.fontName, size: 16)
        nameLabel.textColor = TuneUpTheme.darkColor

        postLabel?.font = UIFont(name: TuneUpTheme.fontName, size: 14)
        postLabel?.textColor = TuneUpTheme.lightColor

        dateLabel.font = UIFont(name: TuneUpTheme.fontName, size: 14)
        dateLabel.textColor = TuneUpTheme.lightColor
     
        photoImageView?.layer.borderWidth = 0.4
        photoImageView?.layer.borderColor = UIColor(white: 0.92, alpha: 1.0).CGColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if postLabel != nil {
            let label = postLabel!
            label.preferredMaxLayoutWidth = CGRectGetWidth(label.frame)
        }
    }
}
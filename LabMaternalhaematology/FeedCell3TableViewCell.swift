//
//  FeedCell3TableViewCell.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 05/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

/* DEBOG ON:LY AND TESTING CLASS*/


import UIKit

class FeedCell3TableViewCell: UITableViewCell {

    // Views
    
    @IBOutlet weak var labelDate: UILabel!

    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelComments: UILabel!
    
    @IBOutlet weak var imageUser: UIImageView!
//    @IBOutlet weak var imageUser: UIImageView!
//    
//    @IBOutlet weak var labelDate: UILabel!
//    
//    //@IBOutlet weak var textViewComments: UITextView!
//    
//    @IBOutlet weak var labelComments: UILabel!
//    @IBOutlet weak var labelCaseNumber: UILabel!
//    @IBOutlet weak var labelUserName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageUser?.layer.borderWidth = 0.4
        imageUser?.layer.borderColor = UIColor(white: 0.92, alpha: 1.0).CGColor

        
        /*
Obj c
@property (nonatomic, weak) IBOutlet UIImageView* profileImageView;

@property (nonatomic, weak) IBOutlet UIImageView* picImageView;

@property (nonatomic, weak) IBOutlet UIView* picImageContainer;

@property (nonatomic, weak) IBOutlet UILabel* nameLabel;

@property (nonatomic, weak) IBOutlet UILabel* updateLabel;

@property (nonatomic, weak) IBOutlet UILabel* dateLabel;

@property (nonatomic, weak) IBOutlet UILabel* commentCountLabel;

@property (nonatomic, weak) IBOutlet UILabel* likeCountLabel;
*/
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

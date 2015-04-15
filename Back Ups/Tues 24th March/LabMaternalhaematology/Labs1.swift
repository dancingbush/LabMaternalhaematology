//
//  Labs1.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 22/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

/*
  Labs 1 : Genral FBC and Coag as other


*/

import UIKit

class Labs1: UIViewController {

    // Insances
    
    
    
    // Views
    
    
    @IBAction func buttonBack(sender: AnyObject) {
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelWCC: UILabel!
    
    @IBOutlet weak var labelOthers: UILabel!
    @IBOutlet weak var labelMCHC: UILabel!
    @IBOutlet weak var labelMCH: UILabel!
    @IBOutlet weak var labelMCV: UILabel!
    @IBOutlet weak var labelPLTS: UILabel!
    @IBOutlet weak var labelHGB: UILabel!
       override func viewDidLoad() {
        super.viewDidLoad()

        // populate labels
        labelWCC.text = "12 - High";
        labelHGB.text = "85-Low"
        labelPLTS.text = "46-Low"
        labelMCH.text = "28-Norm";
        labelMCHC.text = "386-Norm"
        labelMCV.text = "112-N";
        labelOthers.text = "PT = 12s -N\nAPTT = 48s-N\nFib = 1.7 g/L-N";
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

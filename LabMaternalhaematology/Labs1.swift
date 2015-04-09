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
    
    
//    @IBAction func buttonBack(sender: AnyObject) {
//    }
    
    
    @IBOutlet weak var tv_Others: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelWCC: UILabel!
    
   // @IBOutlet weak var labelOthers: UILabel!
    @IBOutlet weak var labelMCHC: UILabel!
    @IBOutlet weak var labelMCH: UILabel!
    @IBOutlet weak var labelMCV: UILabel!
    @IBOutlet weak var labelPLTS: UILabel!
    @IBOutlet weak var labelHGB: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // populate labels
        labelWCC.text = wcc;
        labelHGB.text = hgb;
        labelPLTS.text = plts;
        labelMCH.text = mch;
        labelMCV.text = mcv;
        labelMCHC.text = mchc;
        //labelOthers.text = others;
        tv_Others.text = others;
        
        println(others);
        
        
        
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

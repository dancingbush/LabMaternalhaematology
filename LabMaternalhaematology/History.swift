//
//  History.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 17/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit


// Globals


class History: UIViewController {

    
    
    //Views
    
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var labelAge: UILabel!
    
    @IBOutlet weak var labelSex: UILabel!
    
    @IBOutlet weak var labelTemp: UILabel!
    
    @IBOutlet weak var labelPulse: UILabel!
    
    @IBOutlet weak var labelResperiation: UILabel!
    
    @IBOutlet weak var labelBlooDpressure: UILabel!
    
    @IBOutlet weak var labelAPGAR: UILabel!
    
  
    
    
    @IBOutlet weak var history: UITextView!
    
    //Instances
    
    var historyText = "Prem, 34 weeks, jaundiced, normal delivery, \n APGAR 5."
    var sex = "M";
    var APGAR = "5";
    var temp = "37";
    var age = "2 Weeks";
    
    
    
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        history.text = historyText;
        labelAge.text = age;
        labelPulse.text = temp;
        labelAPGAR.text = APGAR;
        labelSex.text = sex;
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

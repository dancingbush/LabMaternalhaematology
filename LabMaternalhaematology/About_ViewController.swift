//
//  About_ViewController.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 09/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//


/*
Email
http://www.veasoftware.com/tutorials/2015/2/3/in-app-email-in-swift-xcode-6-ios-8-tutorial
*/

import UIKit

class About_ViewController: UIViewController {

    @IBOutlet weak var imageEmailMe: UIImageView!
    
    
    @IBOutlet weak var buttonMainMenu: UIButton!
    
    
    @IBAction func buttonMaineMenu(sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add a tap gesture to image view to call a fucnction
        
        //var target = UITapGestureRecognizer(target: self, action: <#Selector#>("imageTapped"));
        
        
        
        
       // var imageView = <# imageView #>
        var tgr = UITapGestureRecognizer(target:self, action:Selector("imageTapped")) // dont need : as no args
        imageEmailMe.addGestureRecognizer(tgr);
        //imageView.addGestureRecognizer(tgr)
    
    }
    
    func imageTapped(){
        
        println("Image tapped, send an email ");
        
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

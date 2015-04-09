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
import MessageUI

class About_ViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var imageEmailMe: UIImageView!
    
    
    @IBOutlet weak var buttonMainMenu: UIButton!
    
    
    @IBAction func buttonMaineMenu(sender: AnyObject) {
        
        self.performSegueWithIdentifier("segueToMaineMenuFromAbout", sender: self);
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add a tap gesture to image view to call a fucnction
        
        //var target = UITapGestureRecognizer(target: self, action: <#Selector#>("imageTapped"));
        
        
        
        
       // var imageView = <# imageView #>
        var tgr = UITapGestureRecognizer(target:self, action:Selector("imageTapped")) // dont need : as no args
        
        
        imageEmailMe.userInteractionEnabled = true;
        imageEmailMe.addGestureRecognizer(tgr);
        //imageView.addGestureRecognizer(tgr)
    
    }
    
    func imageTapped(){
        
        println("Image tapped, send an email ");
        
        if (MFMailComposeViewController.canSendMail()) {
            
            var emailTitle = "Lab Case Studies: Maternal-Newborn Haematology"
            var messageBody = "Hey, check out this app I have been using for case studies in Laboratory Haematology in a maternal -newborn setting. Cases include 3 questions and micrscopy to interpret, great for CPD! "
            var toRecipents = ["dancingbush@gmail.com"]
            
            var mc:MFMailComposeViewController = MFMailComposeViewController()
            
            mc.mailComposeDelegate = self
            
            mc.setSubject(emailTitle)
            
            mc.setMessageBody(messageBody, isHTML: false)
            
            //mc.setToRecipients(toRecipents)
            
            self.presentViewController(mc, animated: true, completion: nil)
            
        }else {
            
            println("No email account found")
            
        }

        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result.value {
            
        case MFMailComposeResultCancelled.value:
            println("Mail Cancelled")
            displayAlert("Email Error", message: "Possible internet connection issue, please try later or email dancingbush@gmail.com..");
            
        case MFMailComposeResultSaved.value:
            println("Mail Saved")
            
        case MFMailComposeResultSent.value:
            println("Mail Sent")
            displayAlert("Email", message: "SENT!");
        case MFMailComposeResultFailed.value:
            println("Mail Failed")
            displayAlert("Email Error", message: "Possible internet connection issue, please try later or email dancingbush@gmail.com..");
        default:
            break
            
        }
        self.dismissViewControllerAnimated(false, completion: nil)
        
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(title : String, message : String){
        
        //self.loader.stopAnimating();
        
        var alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
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

//
//  MainMenuViewController.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 09/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit
import MessageUI


// Globals


class MainMenuViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    // Views
    
    @IBOutlet weak var labelWelcomeUser: UILabel!
    
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var buttonCases: UIButton!
    
    
    @IBAction func buttonCases(sender: AnyObject) {
        
        self.performSegueWithIdentifier("segueToCaseTableView", sender: self);
        
        
    }
    
    
    @IBAction func buttonLogOut(sender: AnyObject) {
        
        
        PFUser.logOut();
        
        self.performSegueWithIdentifier("segueToLogInScreen", sender: self);
        
    }
    
    @IBAction func buttonAbout(sender: AnyObject) {
    }
    
    
    @IBAction func buttonInivite(sender: AnyObject) {
        
        
        
        if (MFMailComposeViewController.canSendMail()) {
            
            var emailTitle = "Lab Case Studies: Maternal-Newborn Haematology"
            var messageBody = "Hey, check out this app I have been using for case studies in Laboratory Haematology in a maternal -newborn setting. Cases include 3 questions and micrscopy to interpret, great for CPD! "
            //var toRecipents = ["pj@veasoftware.com"]
            
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up emailclient and label welcome
        
        labelWelcomeUser.text = "Welcome \(currentUserName)!";
            }
   
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result.value {
            
        case MFMailComposeResultCancelled.value:
            println("Mail Cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail Saved")
        case MFMailComposeResultSent.value:
            println("Mail Sent")
        case MFMailComposeResultFailed.value:
            println("Mail Failed")
        default:
            break
            
        }
        self.dismissViewControllerAnimated(false, completion: nil)
        
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

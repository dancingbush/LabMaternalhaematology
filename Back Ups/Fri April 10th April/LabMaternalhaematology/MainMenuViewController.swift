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

    /*Manage ransistions*/
    let transitionManager = TransistionManager();
    
    
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
        
        self.performSegueWithIdentifier("segueToAbout", sender: self);
        
        
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
        
        if(isARegsiteredUser){
            
        
        labelWelcomeUser.text = "Welcome Back \(currentUserName)!";
            
    } else {
    
    labelWelcomeUser.text = "Welcome \(currentUserName)!";
    
    
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result.value {
            
        case MFMailComposeResultCancelled.value:
            println("Mail Cancelled")
            
            displayAlert("Email Error", message: "Possible internet connection issue, please try later..");
            
        case MFMailComposeResultSaved.value:
            println("Mail Saved")
        case MFMailComposeResultSent.value:
            println("Mail Sent")
            
            displayAlert("Email", message: "SENT!");
        case MFMailComposeResultFailed.value:
            println("Mail Failed")
            
            displayAlert("Email Error", message: "Possible internet connection issue, please try later..");
        default:
            break
            
        }
        self.dismissViewControllerAnimated(false, completion: nil)
        
        
    }
    }

    func displayAlert(title : String, message : String){
        
        //self.loader.stopAnimating();
        
        var alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue) {
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
            
            // this gets a reference to the screen that we're about to transition to
            
            let toViewController = segue.destinationViewController as UIViewController
            
            // instead of using the default transition animation, we'll ask
            // the segue to use our custom TransitionManager object to manage the transition animation
            
            toViewController.transitioningDelegate = self.transitionManager

        
    }


}

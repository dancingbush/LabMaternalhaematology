//
//  LogInViewController.swift
//  iEnvato
//
//  Created by Daniel Sattler on 17.01.15.
//  Copyright (c) 2015 DA-3D. All rights reserved.
//

// Code that manages everything LogIn related

import UIKit


// Set Global Values that can be accesed from every Screen:
//var userName = ""
//var apiKey = ""
//var balance = ""
//var RealName = ""
//var country = ""
//var avatar = ""
//var earnings = ""
//var spent = ""
//var sales = ""
//var follower = ""
//var themeforestPreValue = ""
//var codecanyonPreValue = ""
//var videohivePreValue = ""
//var audiojungelPreValue = ""
//var graphicriverPreValue = ""
//var photodunePreValue = ""
//var oceanPreValue = ""
//var activedenPreValue = ""
//var accountDetailsLoaded = false
//var itemsByMarketLoaded = false
//var publicDetailsLoaded = false

class LogInViewController: UIViewController {
    
//    let transitionManager = MenuTransitionManager()
//    let accountTransitionManager = MainScreenTransitionManager()
    
    
    @IBOutlet weak var button: UIButton!                // Outlet for the Submit Button
    @IBOutlet weak var loader: UIActivityIndicatorView! // Activity Indicator that appears when submit button is pressed
    @IBOutlet weak var userNameTextField: UITextField!  // Text Field for the Users Name
    @IBOutlet weak var apiKeyTextField: UITextField!    // Text Field for the Users API Key
    
    
    @IBAction func submitButton(sender: AnyObject) {    // Action for the Submit Button
        
        var password = "myPassword";
        
        println("Button Pressed");
        
        // Once the submit button is pressed, disable it so user can´t tap several times
        // Then show the activity indicator and make it spin while loading the data from envato
        //self.button.enabled = false
        self.loader.hidden = false
        self.loader.startAnimating()
        
        
        // chekc if paswod is input
        
        if(apiKeyTextField.text == nil && apiKeyTextField.text==""){
            
            println("No password entered");
            
            
            
        }else{
            
            password = apiKeyTextField.text;
            
            println("Password entered: \(password)");
        }
        
        
        if (userNameTextField.text != ""){
            
            
            var user = PFUser()
            user.username = userNameTextField.text;
            user.password = password;
            //        user.email = "email@example.com"
            //        // other fields can be set just like with PFObject
            //        user["phone"] = "415-392-0202"
            
            user.signUpInBackgroundWithBlock {
                
                (succeeded: Bool!, error: NSError!) -> Void in
                
                if error == nil {
                    
                    // Hooray! Let them use the app now.
                    
                    println("signed up new user! : \(self.userNameTextField.text)");
                    
                    self.loader.stopAnimating();
                    self.loader.hidden = true;
                    
                   // self.performSegueWithIdentifier("segueLogInToTableView", sender: self);
                    
                } else {
                    
                    // Log them in if their username aready exost
                    
                    
                    
                    let errorString = error.userInfo!["error"] as NSString
                    
                    println("Cant sign up so logging this user \(self.userNameTextField.text) in: \(errorString)");
                    
                    
                    PFUser.logInWithUsernameInBackground(self.userNameTextField.text, password:password) {
                        
                        (user: PFUser!, error: NSError!) -> Void in
                        
                        if user != nil {
                            // Do stuff after successful login.
                            
                            println("LOGGED IN!");
                            
                            //self.performSegueWithIdentifier("segueLogInToTableView", sender: self);
                            
                            self.loader.stopAnimating();
                            self.loader.hidden = true;
                            
                            
                        } else {
                            // The login failed. Check error to see why.
                            
                            let theError  = error.userInfo!["error"] as NSString;
                            
                            println("Log in Failed: \(theError)");
                            
                            self.loader.stopAnimating();
                            self.loader.hidden = true;
                        }
                    }
                }
            }
            
        } else {
            
            displayAlert("Alert", message: "Please Enter a Username");
            
            
        }

        
        // Then load everything
//        getCurrentAccountDetails()  // Load Private Account Details
//        getItemsByMarket()          // Load Item Related Details
//        getPublicDetails()          // Load Publically accessable Details
    }
    override func viewDidAppear(animated: Bool) {
        // When the Screen Shows Up or the App is Loaded, check id there is some User Data stored in the Apps Cache.
        // If so, load them.
        self.loader.hidden = true;
           }
    
    
    
    func displayAlert(title : String, message : String){
        
        self.loader.stopAnimating();
        
        var alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // When the Screen Shows Up or the App is Loaded, check id there is some User Data stored in the Apps Cache.
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
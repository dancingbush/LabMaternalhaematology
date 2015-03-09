//
//  LogInViewController.swift
//  iEnvato
//
//  Created by Daniel Sattler on 17.01.15.
//  Copyright (c) 2015 DA-3D. All rights reserved.
//

// Code that manages everything LogIn related

import UIKit
import CoreData



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
        
        
        
        
        // set up database
        //get context objxt and create a user entry with it
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newEntry = NSEntityDescription.insertNewObjectForEntityForName("Cases", inManagedObjectContext: context) as NSManagedObject; // enity = the table name whoch is TableName in this case
        
        //context.deletedObjects;
        
//        From this point on, any changes you make to your Core Data model, such as adding a new Entity or Attribute will lead to an inconsistency in the model of the app in the iPhone Simulator. If this happens to you, you’ll get a really scary looking crash in your app as soon as it starts. You’ll also see something like this show up at the very bottom of your console, “reason=The model used to open the store is incompatible with the one used to create the store”.
//        
//        If this happens to you there is a very easy fix:
//        In the iPhone Simulator, or on your device, just delete the app, and then perform a new Build & Run command in Xcode. This will erase all out of date versions of the model, and allow you to do a fresh run.
        
        

        // do this just once as the entry will besaved as new entry everytme we run the app
        
        // n= 16 attributes
        
        newEntry.setValue(1, forKey: "case");
        
        
//        //HISTORY
//        newEntry.setValue("baby X with Jaundice", forKey: "history");
//        newEntry.setValue("case1a", forKey: "image1");
//        newEntry.setValue("case1b", forKey: "image2");
//        
//        //Q 1
//        newEntry.setValue("What are abnormalites from blood film?", forKey: "question1");
//        newEntry.setValue("Schictocytosis", forKey: "answer1option1");
//        newEntry.setValue("Targets", forKey: "answer1option2");
//        newEntry.setValue("Poik", forKey: "answer1option3");
//        newEntry.setValue("Schictocytosis", forKey: "answer1");
//        
//        //Q2
//        
//        newEntry.setValue("What IS poosible diagnosis?", forKey: "question2");
//        newEntry.setValue("ABo", forKey: "answer2option1");
//        newEntry.setValue("Rhesus Disaese", forKey: "answer2option2");
//        newEntry.setValue("transfsion reaction", forKey: "answer2option3");
//         newEntry.setValue("Rhesus Disaese", forKey: "answer2");
//        
//        //Results
//        newEntry.setValue("FBC \n HB=125 Plt = 67", forKey: "results");
//        
//        //Parse Image = nil if not downloadung form parse
//        newEntry.setValue(nil, forKey: "parseimage");
//        
//        newEntry.setValue("HDN", forKey: "answer1");
//        newEntry.setValue("case1b", forKey: "image2");
//        newEntry.setValue("case1b", forKey: "image2");
//        newEntry.setValue("case1b", forKey: "image2");
//        
//        //Summary
//        newEntry.setValue("HDN is a disase of newborn vlah b;ah b;ah", forKey: "summary");
//        
//        
//        
//        var error : NSError? = nil;
//        
//        // save to DB and handle error if present
//        context.save(&error);
//        
//        
//        
//        
//        // GET DATA FTOM DB
//        var request = NSFetchRequest(entityName: "Cases"); // enoty = table name
//        
//        
//        // for beta 4 xcode only
//        request.returnsObjectsAsFaults = false;
//        
//        
//        // do a search, thos will return a results array with search results only!
//        //request.predicate = NSPredicate(format: "username = %@", "Susan"); //%@ is placeholede r for string we want to search for
//        
//        
//        
//        // get array of results
//        var results = context.executeFetchRequest(request, error: nil);
//        println("Results from DB \(results)");
//        
//        
//        //loop through results array and fist check result not null
//        
//        if results?.count > 0{
//            
//            
//            for result : AnyObject in results! {
//                
//                
//                println("Delting: \(result)");
//                
//                //context.delete(result);
//                
//                // Handle result : anyobject optional type by using a if - let staement
////                if let username = result.valueForKey("username") as? String {
////                    
////                    println(username);
////                    
////                    // delete a result
////                    if (username == "Susan"){
////                        
////                        // DELETE AN ENTRY
////                        //context.deleteObject(result as NSManagedObject); // forse downcast result : anyobject to NSMAnagedObject
////                        //println(username + " has been deleted");
////                        
////                        
////                        //UPDATE A ENTRY IE PASSWORD
////                        result.setValue("betterPassword", forKey: "password");
////                        var newP = result.valueForKey("password") as String;
////                        
////                        println(username + " password changed to " + newP);
////                        
////                        
////                    }
////                    
////                    
////                }
//                
//                
//                
//                // Search database for result
//                
//                // save changes
//                context.save(nil);
//                
//                
//            }
//        } else{
//            
//            println("No Data, no of entries = \(results?.count)");
//        }
        

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
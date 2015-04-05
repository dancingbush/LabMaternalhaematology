//
//  FeedController3TableViewController.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 05/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit

class FeedController3TableViewController: UITableViewController {

    
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var userComments = ""; // add to parse
    
    var currentCase = caseNumber; // search for comment in pasre for this case
    
    var arrayOfComments : [String] = [];
    
    var arrayOfUserNames : [String] = [];
    
    var arrayOfTimeStamps : [String] = [];
    
    var arrayOfCaseImages : [String] = [];
    
    var finsihedLoadingFormParse = false;
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        userComments = "This caseis amzing, the cpder is even more amaxong.\nBollix to this imgign home now good sir\nGoodbye!";
        
        var tome = printTimestamp();
        
        caseNumber = "1";
        
        println("Comments, tome stamp and case : \(userComments) : \(tome) : \(caseNumber)");
        
        addComment();
        
    }
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    
    
    
    func printTimestamp() -> String{
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        println(timestamp);
        //println("Time of Post COmment : \(timestamp)";
        
        return timestamp;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 10;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        
        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    func addComment(){
        
        // add comment form user to parse object
        var error = ""
        
        if (userComments == "") {
            
            error = "Please enter a comment!"
            
        }
        
        if (error != "") {
            
            displayAlert("Cannot Post Comment", error: error)
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var comment = PFObject(className: "Comments");
            comment["comment"] = userComments;
            comment["user"] = "testUserName";
            //comment["user"] = PFUser.currentUser().username;
            comment["caseNumber"] = caseNumber;
            comment["imageTitle"] = "case1b";
            
            var timeOfPost = printTimestamp();
            comment["time"] = timeOfPost;
            
            //            var post = PFObject(className: "Comments")
            //            post["Title"] = userComments;
            //            post["username"] = PFUser.currentUser().username
            
            
            
            comment.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                
                
                if success == false {
                    
                    // turn off user interaction dosabled and display timer
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.displayAlert("Could Not Post Comment- Check internet connection!", error: "Please try again later")
                    
                } else {
                    
                    // swotch user interaction back on
                    
                    // turn off user interaction dosabled and display timer
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    // Print post objects to log
                    
                    var getCommentsFromParse = PFQuery(className: "Comments");
                
                    println("Saved to parse....");
                    
                    var getFollowedUsersQuery = PFQuery(className: "followers")
                    //getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser().username)
                    getCommentsFromParse .findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]!, error: NSError!) -> Void in
                        
                        if error == nil {
                            
                            //var followedUser = ""
                            
                            for object in objects {
                                
                                // Update - replaced as with as!
                                
                                //followedUser = object["following"] as! String
                                println("Object retribed form parse!");
                                
                                println(object);
                                
                                // save tp arrays for table view
                                self.arrayOfUserNames.append(object["user"] as String);
                                self.arrayOfComments.append(object["comment"] as String);
                                self.arrayOfTimeStamps.append(object["time"] as String);
                                self.arrayOfCaseImages.append(object["imageTitle"] as String);
                                
                                
                                //                                var query = PFQuery(className:"Post")
                                //                                query.whereKey("username", equalTo:followedUser)
                                //                                query.findObjectsInBackgroundWithBlock {
                                //                                    (objects: [AnyObject]!, error: NSError!) -> Void in
                                //                                    if error == nil {
                                //                                        // The find succeeded.
                                //                                        println("Successfully retrieved \(objects.count) scores.")
                                //                                        // Do something with the found objects
                                //                                        for object in objects {
                                //
                                //                                            // Update - replaced as with as!
                                //
                                //                                            self.titles.append(object["Title"] as! String)
                                //
                                //                                            // Update - replaced as with as!
                                //
                                //                                            self.usernames.append(object["username"] as! String)
                                //
                                //                                            // Update - replaced as with as!
                                //
                                //                                            self.imageFiles.append(object["imageFile"] as! PFFile)
                                //
                                //                                            self.tableView.reloadData()
                                
                                //
                            }// for
                            
                            self.finsihedLoadingFormParse = true;
                            
                        } else {
                            // Log details of the failure
                            println(error)
                        }
                    }
                }
                
                // turn off user interaction dosabled and display timer
                
                // Print arrays form parse only if finished as its run asynchrounly
                if(self.finsihedLoadingFormParse){
                println("\nUserbame Array : \(self.arrayOfUserNames)");
                println("\nUserbame Array : \(self.arrayOfComments)");
                println("\nUserbame Array : \( self.arrayOfTimeStamps)");
                println("\nUserbame Array : \(self.arrayOfTimeStamps)");
                }
                
                
            }// add comments func
            
       // }
        
        
        
        // aving image to app
        
        //                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
        //
        //                    let imageFile = PFFile(name: "image.png", data: imageData)
        //
        //                    post["imageFile"] = imageFile
        //
        //                    post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
        //
        //                        self.activityIndicator.stopAnimating()
        //                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        //
        //                        if success == false {
        //
        //                            self.displayAlert("Could Not Post Image", error: "Please try again later")
        //
        //                        } else {
        //
        //                            self.displayAlert("Image Posted!", error: "Your image has been posted successfully")
        //                            
        //                            // Update - replaced 0 with false
        //                            
        //                            self.photoSelected = false
        //                            
        //                            self.imageToPost.image = UIImage(named: "315px-Blank_woman_placeholder.svg")
        //                            
        //                            self.shareText.text = ""
        //                            
        //                            println("posted successfully")
        
    }
    
}

//                }
//                
//                
//            }
//            
//            
//            
//        }





//}


}// class

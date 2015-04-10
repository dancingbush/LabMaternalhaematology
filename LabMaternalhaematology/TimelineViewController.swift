//
//  TimelineViewController.swift
//  Mega
//
//  Created by Tope Abayomi on 19/11/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

import Foundation
import UIKit

class TimelineViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    /* Manage transistions bewteen vc's*/
    var transitionManager = TransistionManager();
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var toolbar : UIToolbar!
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var userComments = ""; // add to parse
    
    var currentCase = caseNumber; // search for comment in pasre for this case
    
    var arrayOfComments : [String] = [];
    
    var arrayOfUserNames : [String] = [];
    
    var arrayOfTimeStamps : [String] = [];
    
    var arrayOfCaseImages : [String] = [];
    
    
    
    var finsihedLoadingFormParse = false;
    

    // Footer veow for comments
    var commentView: UITextView?
    var footerView: UIView?
    var contentHeight: CGFloat = 0
    
    var comments: [String]?
    let FOOTERHEIGHT : CGFloat = 50;
    
    var userComemnts="";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set toolbar bg
        
        let toolBarbg = UIImage(named: "Background")
        
        toolbar.setBackgroundImage(toolBarbg, forToolbarPosition: .Bottom, barMetrics: .Default);
        
//        let toolbarBackgroundImage = UIImage(named: "toolbar_background")
//        toolbar.setBackgroundImage(toolbarBackgroundImage, forToolbarPosition: .Bottom, barMetrics: .Default)
//        
//        let toolbarButtonItems = [
//            customImageBarButtonItem,
//            flexibleSpaceBarButtonItem,
//            customBarButtonItem
//        ]
//        toolbar.setItems(toolbarButtonItems, animated: true)

//        /* Setup the keyboard notifications  so does not block textview for adding comments */
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        /* Setup the contentInsets fo keyboard  */
        self.tableView.contentInset = UIEdgeInsetsZero
       self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero
       
      self.edgesForExtendedLayout = UIRectEdge.None

                /* Make sure the content doesn't go below tabbar/navbar */
       self.extendedLayoutIncludesOpaqueBars = true
       self.automaticallyAdjustsScrollViewInsets = false

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        toolbar.tintColor = UIColor.blackColor()
        
        var tome = printTimestamp();
        
        caseNumber = caseNumberString;
        
        println("Comments, tome stamp and case : \(userComments) : \(tome) : \(caseNumber)");
        
        //addComment();
        
        
        self.loadDataFromParse();
        
        

    }
    
    func loadDataFromParse(){
        
        var getCommentsFromParse = PFQuery(className: "Comments");
        
        println("Loading form parse....");
        
        /* Turn on activity indicator and turn off when done in aysn block */
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        
        //var getFollowedUsersQuery = PFQuery(className: "followers")
        //getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser().username)
        
        println("Getting object form parse where case is = \(caseNumber) only");
        
        getCommentsFromParse.whereKey("caseNumber", equalTo: caseNumber);
        
        getCommentsFromParse .findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                
                self.activityIndicator.stopAnimating();
                UIApplication.sharedApplication().endIgnoringInteractionEvents();
                
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
                
                //                // once arrays populated reload table data
                //                self.tableView.reloadData();
                //
                //                self.configureTableView();
                //
                self.finsihedLoadingFormParse = true;
                
            } else {
                // Log details of the failure
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                println(error)
            }
            
            //self.configureTableView();
            
            self.tableView.reloadData();
            
            // load the last row
            
           // let offset = CGPoint(x: 0, y: self.FOOTERHEIGHT);
            let offset = CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height + self.FOOTERHEIGHT);
            
            self.tableView.contentOffset = offset;
            
//            let numberOfSections = self.tableView.numberOfSections()
//            let numberOfRows = self.tableView.numberOfRowsInSection(numberOfSections-1)
//            
//            if numberOfRows > 0 {
//                println(numberOfSections)
//                println("Scrolling to row number \(numberOfRows)");
//                
//                //let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
//                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
//                
//                //self.tableView.scrollToRowAtIndexPath(<#indexPath: NSIndexPath#>, atScrollPosition: <#UITableViewScrollPosition#>, animated: <#Bool#>)
//                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
//               
//                // check what last cell is 
//                if let cell : TimelineCell = self.tableView.cellForRowAtIndexPath(indexPath)? as? TimelineCell{
//                    
//                
//               println("Last row comments: \(cell.postLabel?.text)");
//                }
//                //UITableViewCell cell = self.tableView.cellForRowAtIndexPath(indexPath)
//            }
            
            
            
            
        }// background task
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
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

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if(arrayOfComments.count > 0){
            
            return arrayOfComments.count
            
        } else{
            
            return 5;
            
        }

        //return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        //if (indexPath.row % 2 == 0) {
         let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as TimelineCell
        
        if(indexPath.row % 2 == 0){
            
            cell.typeImageView.image = UIImage(named: "timeline-chat")
             cell.profileImageView.image = UIImage(named: "placeholder1")
            
        }else{
            
            cell.typeImageView.image = UIImage(named: "timeline-photo")
             cell.profileImageView.image = UIImage(named: "placeholder2")
        }
        
           // cell.typeImageView.image = UIImage(named: "timeline-chat")
            //cell.profileImageView.image = UIImage(named: "placeholder1")
            
            if(arrayOfComments.count > 0){
                

                cell.nameLabel.text = arrayOfUserNames[indexPath.row];
            
            
                cell.postLabel?.text = arrayOfComments[indexPath.row];
                
                let casedetails = "Case: \(caseNumber) - ";
            cell.dateLabel.text = casedetails + arrayOfTimeStamps[indexPath.row];
               
                cell.profileImageView.image = UIImage(named: arrayOfCaseImages[indexPath.row]+".jpg" as String)
            }
            return cell

//        }else{
//            let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCellPhoto") as TimelineCell
//            
//            cell.typeImageView.image = UIImage(named: "timeline-chat")
//            cell.profileImageView.image = UIImage(named: "profile-pic-1")
//            
//            if(arrayOfComments.count > 0){
//                
//                
//                cell.nameLabel.text = arrayOfUserNames[indexPath.row];
//                
//                
//                cell.postLabel?.text = arrayOfComments[indexPath.row];
//                
//                cell.dateLabel.text = arrayOfTimeStamps[indexPath.row];
//                
//                cell.profileImageView.image = UIImage(named: arrayOfCaseImages[indexPath.row]+".jpg" as String)
//            }
//            cell.typeImageView.image = UIImage(named: "timeline-photo")
//            cell.profileImageView.image = UIImage(named: "profile-pic-2")
//            cell.nameLabel.text = "Linda Hoylett"
//            cell.photoImageView?.image = UIImage(named: "dish")
//            cell.dateLabel.text = "2 mins ago"
//            return cell
//        }
    }
    
    @IBAction func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){

    }
    
   func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
    
        
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: FOOTERHEIGHT))
        footerView?.backgroundColor = UIColor(red: 243.0/255, green: 243.0/255, blue: 243.0/255, alpha: 1)
    
        commentView = UITextView(frame: CGRect(x: 10, y: 5, width: tableView.bounds.width - 80 , height: 40))
        commentView?.backgroundColor = UIColor.whiteColor()
        commentView?.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        commentView?.layer.cornerRadius = 2
        commentView?.scrollsToTop = true
        
        footerView?.addSubview(commentView!)
        let button = UIButton(frame: CGRect(x: tableView.bounds.width - 65, y: 10, width: 60 , height: 30))
    
    button.setBackgroundImage(UIImage(named: "Background"), forState: .Normal);
        
     button.setTitle("Add", forState: UIControlState.Normal)
        //button.backgroundColor = UIColor(red: 155.0/255, green: 189.0/255, blue: 113.0/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: "reply", forControlEvents: UIControlEvents.TouchUpInside)
        footerView?.addSubview(button)
        commentView?.delegate = self
        
        return footerView
        
        //return footerView;
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        
        if self.footerView != nil {
            return self.footerView!.bounds.height
        }
        return FOOTERHEIGHT
        
        //return 70.0
    }
    
    
    func keyBoardWillShow(notification: NSNotification) {
        
        // Called in viewDidlOag, make sure keyoard doe snot cover add comments textview in table voew footer
        
        var info:NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()
        
        var keyboardHeight:CGFloat =  keyboardSize.height - 40
        
        var animationDuration:CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as CGFloat
        
        var contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
        
    }
    
    func keyBoardWillHide(notification: NSNotification) {
        
        //As above
        
        self.tableView.contentInset = UIEdgeInsetsZero
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    
    func textViewDidChange(textView: UITextView) {
        
        // Allow for dynamic chaniong oif TableView Footer textview size when commenst added
        
        if (contentHeight == 0) {
            contentHeight = commentView!.contentSize.height
        }
        
        if(commentView!.contentSize.height != contentHeight && commentView!.contentSize.height > footerView!.bounds.height) {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                let myview = self.footerView
                println(self.commentView!.contentSize.height)
                println(self.commentView?.font.lineHeight)
                let newHeight : CGFloat = self.commentView!.font.lineHeight
                let myFrame = CGRect(x: myview!.frame.minX, y: myview!.frame.minY - newHeight , width: myview!.bounds.width, height: newHeight + myview!.bounds.height)
                myview?.frame = myFrame
                
                let mycommview = self.commentView
                let newCommHeight : CGFloat = self.commentView!.contentSize.height
                let myCommFrame = CGRect(x: mycommview!.frame.minX, y: mycommview!.frame.minY, width: mycommview!.bounds.width, height: newCommHeight)
                mycommview?.frame = myCommFrame
                
                self.commentView = mycommview
                self.footerView  = myview
                
                for item in self.footerView!.subviews {
                    if(item.isKindOfClass(UIButton.self)){
                        let button = item as UIButton
                        let newY = self.footerView!.bounds.height / 2 - button.bounds.height / 2
                        let buttonFrame = CGRect(x: button.frame.minX, y: newY , width: button.bounds.width, height : button.bounds.height)
                        button.frame = buttonFrame
                        
                    }
                }
            })
            
            println(self.footerView?.frame)
            println(self.commentView?.frame)
            contentHeight = commentView!.contentSize.height
        }
        
        
    }
    
  
    func reply() {
        
        // When Add button clicked in custom TabkeView Footer
        
//        println("User added comment: \(commentView?.text)");
//        
//        //        yak?.addObject(commentView?.text, forKey: "comments")
//        //        yak?.saveInBackground()
//        //        if let tmpText = commentView?.text {
//        //            comments?.append(tmpText)
//        //        }
//        //        commentView?.text = ""
//       
//        userComemnts = commentView!.text;
//        
//        println("Comments to add : \(userComemnts)");
//        println(comments?.count)
//        
//        self.commentView?.resignFirstResponder()
//        
//         self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
//        //tableView.reloadData();
//        //userComments = commentView!.text;
//        
//        
//        
//        
//        addComment();
        println("User added comment: \(commentView?.text)");
        
        //        yak?.addObject(commentView?.text, forKey: "comments")
        //        yak?.saveInBackground()
        if let Comments  = commentView?.text {
            //comments?.append(tmpText)
            
            self.userComments = Comments;
            println(userComments);
            
        }
        commentView?.text = ""
        println(comments?.count)
        self.commentView?.resignFirstResponder()
        //
        //        println(commentView?.text)
        //        yak?.addObject(commentView?.text, forKey: "comments")
        //        commentView?.text = ""
        //        self.commentView?.resignFirstResponder()
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
       
        addComment();
        
        //self.tableView.reloadData()
        
        //self.configureTableView();
    }
    
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
            comment["user"] = PFUser.currentUser().username;
            //comment["user"] = PFUser.currentUser().username;
            comment["caseNumber"] = caseNumber;
            comment["imageTitle"] = "case\(caseNumberString)a";
            
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
                    
                    //                    var getFollowedUsersQuery = PFQuery(className: "followers")
                    //                    //getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser().username)
                    //                    getCommentsFromParse .findObjectsInBackgroundWithBlock {
                    //                        (objects: [AnyObject]!, error: NSError!) -> Void in
                    //
                    //                        if error == nil {
                    //
                    //                            //var followedUser = ""
                    //
                    //                            for object in objects {
                    //
                    //                                // Update - replaced as with as!
                    //
                    //                                //followedUser = object["following"] as! String
                    //                                println("Object retribed form parse!");
                    //
                    //                                println(object);
                    //
                    //                                // save tp arrays for table view
                    //                                self.arrayOfUserNames.append(object["user"] as String);
                    //                                self.arrayOfComments.append(object["comment"] as String);
                    //                                self.arrayOfTimeStamps.append(object["time"] as String);
                    //                                self.arrayOfCaseImages.append(object["imageTitle"] as String);
                    //
                    //
                    //                                //                                var query = PFQuery(className:"Post")
                    //                                //                                query.whereKey("username", equalTo:followedUser)
                    //                                //                                query.findObjectsInBackgroundWithBlock {
                    //                                //                                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    //                                //                                    if error == nil {
                    //                                //                                        // The find succeeded.
                    //                                //                                        println("Successfully retrieved \(objects.count) scores.")
                    //                                //                                        // Do something with the found objects
                    //                                //                                        for object in objects {
                    //                                //
                    //                                //                                            // Update - replaced as with as!
                    //                                //
                    //                                //                                            self.titles.append(object["Title"] as! String)
                    //                                //
                    //                                //                                            // Update - replaced as with as!
                    //                                //
                    //                                //                                            self.usernames.append(object["username"] as! String)
                    //                                //
                    //                                //                                            // Update - replaced as with as!
                    //                                //
                    //                                //                                            self.imageFiles.append(object["imageFile"] as! PFFile)
                    //                                //
                    //                                //                                            self.tableView.reloadData()
                    //
                    //                                //
                    //                            }// for
                    //
                    //                            // once arrays populated reload table data
                    //                            self.tableView.reloadData();
                    //
                    //                            self.finsihedLoadingFormParse = true;
                    //
                    //                        } else {
                    //                            // Log details of the failure
                    //                            println(error)
                    //                        }
                    //}
                }
                
                // turn off user interaction dosabled and display timer
                
                //                // Print arrays form parse only if finished as its run asynchrounly
                //                if(self.finsihedLoadingFormParse){
                //                println("\nUserbame Array : \(self.arrayOfUserNames)");
                //                println("\nUserbame Array : \(self.arrayOfComments)");
                //                println("\nUserbame Array : \( self.arrayOfTimeStamps)");
                //                println("\nUserbame Array : \(self.arrayOfTimeStamps)");
                //                }
                
                
                // reload table but get data form parse first
                self.loadDataFromParse();
                
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


     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        
        toViewController.transitioningDelegate = self.transitionManager

    }
} // class


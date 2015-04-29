//
//  FeedController3TableViewController.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 05/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

/* DEBUG ONLY AND TESTING*/

import UIKit

class FeedController3TableViewController: UITableViewController, UITextViewDelegate {

    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.edgesForExtendedLayout = UIRectEdge.None
        
        /* Setup the keyboard notifications  so does 
        not block textview for adding comments */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
        /* Setup the contentInsets fo keyboard  */
        self.tableView.contentInset = UIEdgeInsetsZero
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero
        
        
        self.edgesForExtendedLayout = UIRectEdge.None
        /* Make sure the content doesn't go below tabbar/navbar */
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.automaticallyAdjustsScrollViewInsets = false

//        tableView.estimatedRowHeight = 74.0;
//        tableView.rowHeight = UITableViewAutomaticDimension;
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //userComments = "Tis is secnd test comment on case, case umber 2 blah blah blah blah bahl case umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahlcase umber 2 blah blah blah blah bahl !";
        
        var tome = printTimestamp();
        
        caseNumber = "2";
        
        println("Comments, tome stamp and case : \(userComments) : \(tome) : \(caseNumber)");
        
       //addComment();
        
        
        self.loadDataFromParse();
        
        
        // Set row height dynamically
        //configureTableView();
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        println("Scrolling");
        
        
    }
    
//    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        //
//        tableView.reloadData();
//        self.configureTableView();
//    }
    
    
//    func perfomrWithCompleteionHandler(completion : (AnyObject?, AnyObject) -> Void){
//        
//        var resultOfOpeartion1: AnyObject?
//        
//        let operation1 = NSBlockOperation{
//            
//            let dispatchGroup = dispatch_group_create();
//            dispatch_group_enter(dispatchGroup);
//            self.loadDataFromParse({ (resukt) -> Void in
//                dispatch_group_leave(dispatchGroup);
//            })
//        }
//    }
    
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

        
        var getFollowedUsersQuery = PFQuery(className: "followers")
        //getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser().username)
        
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
            
            

    
        }// background task
      
        
//        // once arrays populated reload table data
//        self.tableView.reloadData();
//        
//        self.configureTableView();
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
        
        if(arrayOfComments.count > 0){
            
            return arrayOfComments.count
            
        } else{
        
        return 1;
            
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as FeedCell3TableViewCell
        
        
        // Configure the cell...make sure we have data as arrays are populated asynchrounsly from Parse
        
        if(arrayOfComments.count > 0){
            
            
        
        cell.labelDate.text = arrayOfTimeStamps[indexPath.row];
        cell.labelUserName.text = arrayOfUserNames[indexPath.row];
        //cell.textViewComments.text = arrayOfComments[indexPath.row];
        cell.imageUser.image = UIImage(named: arrayOfCaseImages[indexPath.row]+".jpg" as String);
        cell.labelComments.text = arrayOfComments[indexPath.row];
            //cell.labelCaseNumber.text = caseNumber;
            
        }
        
        
        
        
        return cell
    }
   

    func configureTableView() {
        
         /*  When you set the rowHeight as UITableViewAutomaticDimension, the table view knows to use the auto layout constraints to determine each cell’s height. This also reuqires a estimetedRowHeoght, an arbitary number */
        
        println("Configure Table View called")
        
        tableView.estimatedRowHeight = 74.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
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

//                }
//                
//                
//            }
//            
//            
//            
//        }





//}


    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        //let  footerCell = tableView.dequeueReusableCellWithIdentifier("FooterCell") as CustomFotterCell;
        
        //footerCell.backgroundColor = UIColor.cyanColor()
        println("Footerview")
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100))
        footerView?.backgroundColor = UIColor(red: 243.0/255, green: 243.0/255, blue: 243.0/255, alpha: 1)
        commentView = UITextView(frame: CGRect(x: 10, y: 5, width: tableView.bounds.width - 80 , height: 40))
        commentView?.backgroundColor = UIColor.whiteColor()
        commentView?.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        commentView?.layer.cornerRadius = 2
        commentView?.scrollsToTop = true
        
        footerView?.addSubview(commentView!)
        let button = UIButton(frame: CGRect(x: tableView.bounds.width - 65, y: 10, width: 60 , height: 30))
        button.setTitle("Reply", forState: UIControlState.Normal)
        button.backgroundColor = UIColor(red: 155.0/255, green: 189.0/255, blue: 113.0/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: "reply", forControlEvents: UIControlEvents.TouchUpInside)
        footerView?.addSubview(button)
        commentView?.delegate = self
        println(self.tableView.frame)
        println(self.footerView?.frame)
        println(self.footerView?.bounds)
        return footerView

        
        //let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
       // footerView.backgroundColor = UIColor.blackColor()
//        
//        footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: FOOTERHEIGHT))
//        footerView?.backgroundColor = UIColor(red: 243.0/255, green: 243.0/255, blue: 243.0/255, alpha: 1)
//        commentView = UITextView(frame: CGRect(x: 10, y: 5, width: tableView.bounds.width - 80 , height: 40))
//        commentView?.backgroundColor = UIColor.whiteColor()
//        commentView?.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
//        commentView?.layer.cornerRadius = 2
//        commentView?.scrollsToTop = true
//        
//        footerView?.addSubview(commentView!)
//        let button = UIButton(frame: CGRect(x: tableView.bounds.width - 65, y: 10, width: 60 , height: 30))
//        button.setTitle("Reply", forState: UIControlState.Normal)
//        button.backgroundColor = UIColor(red: 155.0/255, green: 189.0/255, blue: 113.0/255, alpha: 1)
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: "reply", forControlEvents: UIControlEvents.TouchUpInside)
//        footerView?.addSubview(button)
//        commentView?.delegate = self
//        
//        return footerView
        
        //return footerView;
    }
    
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if self.footerView != nil {
            return self.footerView!.bounds.height
        }
        return 50
//        if self.footerView != nil {
//            return self.footerView!.bounds.height
//        }
//        return FOOTERHEIGHT
        
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

//        if (contentHeight == 0) {
//            contentHeight = commentView!.contentSize.height
//        }
//        
//        if(commentView!.contentSize.height != contentHeight && commentView!.contentSize.height > footerView!.bounds.height) {
//            UIView.animateWithDuration(0.2, animations: { () -> Void in
//                let myview = self.footerView
//                println(self.commentView!.contentSize.height)
//                println(self.commentView?.font.lineHeight)
//                let newHeight : CGFloat = self.commentView!.font.lineHeight
//                let myFrame = CGRect(x: myview!.frame.minX, y: myview!.frame.minY - newHeight , width: myview!.bounds.width, height: newHeight + myview!.bounds.height)
//                myview?.frame = myFrame
//                
//                let mycommview = self.commentView
//                let newCommHeight : CGFloat = self.commentView!.contentSize.height
//                let myCommFrame = CGRect(x: mycommview!.frame.minX, y: mycommview!.frame.minY, width: mycommview!.bounds.width, height: newCommHeight)
//                mycommview?.frame = myCommFrame
//                
//                self.commentView = mycommview
//                self.footerView  = myview
//                
//                for item in self.footerView!.subviews {
//                    if(item.isKindOfClass(UIButton.self)){
//                        let button = item as UIButton
//                        let newY = self.footerView!.bounds.height / 2 - button.bounds.height / 2
//                        let buttonFrame = CGRect(x: button.frame.minX, y: newY , width: button.bounds.width, height : button.bounds.height)
//                        button.frame = buttonFrame
//                        
//                    }
//                }
//            })
//            
//            println(self.footerView?.frame)
//            println(self.commentView?.frame)
//            contentHeight = commentView!.contentSize.height
//        }
//        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        // fixes bug where some cells wiyh long text dont size properply
        super.viewDidAppear(animated)

        println("View Did Appear");
        
         configureTableView();
        
       tableView.reloadData();
        //self.tableView.reloadData();
        
       
        
        
    }
    func reply() {
        
        // When Add button clicked in custom TabkeView Footer
        
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

        //userComments = commentView!.text;
        
       // addComment();
        
        
//        self.tableView.reloadData()
//        
//        self.configureTableView();
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 4, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        
    }

    
//   override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        //
//    
//    tableView.estimatedRowHeight = 74.0;
//    tableView.rowHeight = UITableViewAutomaticDimension;
//    
//    return tableView.rowHeight;
//        
//    }
}

//}// class

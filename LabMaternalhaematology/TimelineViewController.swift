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
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var toolbar : UIToolbar!
    
    // Footer veow for comments
    var commentView: UITextView?
    var footerView: UIView?
    var contentHeight: CGFloat = 0
    
    var comments: [String]?
    let FOOTERHEIGHT : CGFloat = 50;
    
    var userComemnts="";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if (indexPath.row % 2 == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as TimelineCell
            
            cell.typeImageView.image = UIImage(named: "timeline-chat")
            cell.profileImageView.image = UIImage(named: "profile-pic-1")
            cell.nameLabel.text = "John Hoylett"
            
            if(userComemnts != ""){
                cell.postLabel?.text = userComemnts;
            }else{
            cell.postLabel?.text = "Checking out of the hotel today. It was really fun to see everyone and catch up. We should have more conferences like this so we can share ideas."
            }
            
            cell.dateLabel.text = "2 mins ago"
            return cell

        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCellPhoto") as TimelineCell
            
            cell.typeImageView.image = UIImage(named: "timeline-photo")
            cell.profileImageView.image = UIImage(named: "profile-pic-2")
            cell.nameLabel.text = "Linda Hoylett"
            cell.photoImageView?.image = UIImage(named: "dish")
            cell.dateLabel.text = "2 mins ago"
            return cell
        }
    }
    
    @IBAction func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){

    }
    
   func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        //let  footerCell = tableView.dequeueReusableCellWithIdentifier("FooterCell") as CustomFotterCell;
        
        //footerCell.backgroundColor = UIColor.cyanColor()
        
        
        //let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        // footerView.backgroundColor = UIColor.blackColor()
        
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: FOOTERHEIGHT))
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
        
        println("User added comment: \(commentView?.text)");
        
        //        yak?.addObject(commentView?.text, forKey: "comments")
        //        yak?.saveInBackground()
        //        if let tmpText = commentView?.text {
        //            comments?.append(tmpText)
        //        }
        //        commentView?.text = ""
       
        userComemnts = commentView!.text;
        
        println(comments?.count)
        self.commentView?.resignFirstResponder()
         self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
        //tableView.reloadData();
        //userComments = commentView!.text;
        
        //addComment();
        
        
        //self.tableView.reloadData()
        
        //self.configureTableView();
    }

}

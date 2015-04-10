//
//  CasesTableViewTableViewController.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 30/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit
import CoreData

class CasesTableViewTableViewController: UITableViewController {
    
    // Instances
    var caseNumberForResultCheck = ""; // need for user deafults
    
    
    // views
    
    @IBOutlet weak var imageviewBlue: UIImageView!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        
        println("Back Button Pressed");
        
        
        self.performSegueWithIdentifier("segueBackToMainMenu", sender: self);
    
    }
    
    
    //Instacnces
    
    var caseNumberToPAsstoHistory : String = "";
    
    var arrayOfCaseNumbers : [String] = [];
    
    var totalCases = 0;
    
    var arrayOfCaseSummaries : [String] = [];
    
    var arrayOfIMageNames : [String] = [];
    
    

    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get context objxt and create a user entry with it
        
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newEntry2 = NSEntityDescription.insertNewObjectForEntityForName("Case", inManagedObjectContext: context) as NSManagedObject;
        
        
        
        // GET DATA FTOM DB
        var request = NSFetchRequest(entityName: "Case");
        //var request = NSFetchRequest(entityName: "Cases"); // enoty = table name
        
        
        // for beta 4 xcode only
        request.returnsObjectsAsFaults = false;
        
        
        // do a search, thos will return a results array with search results only!
        //request.predicate = NSPredicate(format: <#String#>, <#args: CVarArgType#>...)
        //request.predicate = NSPredicate(format: "username = %@", "Susan"); //%@ is placeholede r for string we want to search for
        
        
        
        // get array of results
        
        var results = context.executeFetchRequest(request, error: nil);
        println("Results from DB \(results)");
        
        
        //loop through results array and fist check result not null
        
        
        if results?.count > 0{
            
            var index = 0;
            
            for result : AnyObject in results! {
                
                
                //println("Printing DataBSE Results: \(result)\n\n");
                
                // add to arrays only of not a nil entry
                
                if(result.valueForKey("caseNumber") != nil ){
                    
                    
                    caseNumberForResultCheck = result.valueForKey("caseNumber") as String;
                    
                
                arrayOfCaseNumbers.append(result.valueForKey("caseNumber") as String);
                
                
                
                arrayOfCaseSummaries.append(result.valueForKey("caseSummary") as String);
                
                arrayOfIMageNames.append(result.valueForKey("question1Image1")as String);
                
                totalCases = results!.count;
                
                println("DB Data : CAse Number : \(arrayOfCaseNumbers[index]) Case Summary: \(arrayOfCaseSummaries[index]) Image Name : \(arrayOfIMageNames[index]) and Total Cases: \(totalCases) ");
                
                
                index = 1+index;
                }
                
                
                
                           }
        } else{
            
            println("No Data, no of entries = \(results?.count)");
        }
        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return arrayOfCaseNumbers.count;
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
     
        // Populate the custom cell
        
        let caseCell : CasesTableViewCell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as CasesTableViewCell;
        
        caseCell.imageLeft.image = UIImage(named: arrayOfIMageNames[indexPath.row] as String);
        
        caseCell.labelCaseNo.text = arrayOfCaseNumbers[indexPath.row] as String + "/\(totalCases)";
        
        caseCell.labelTop.text = arrayOfCaseSummaries[indexPath.row];
        
        
        // Set label scroe according to how user scored the case, saved to NSUserdefaults in Summary.swift
        
        let defaults = NSUserDefaults.standardUserDefaults();
        
        
        // if -let will only work if we reurn an optional value, wgere array[inde] is not optional it will/should always retin a value
        
       
        
        var caseNumberD = arrayOfCaseNumbers[indexPath.row] as String;
        
        var hasResult : Bool = false;
        
        if let scoreValueArray : [Dictionary<String, String>]  = defaults.objectForKey("userScoreForCase") as? Array{
            
            
            for dict_Result in scoreValueArray{
                
                
            
            println("Array Of Dictioanry \(scoreValueArray) and count is = \(scoreValueArray.count)");
            
            // element = the case number
            //let elementCaseNumber = caseNumber;
            
            //var dict = scoreValueArray[0];
            
                //var value = dict["CaseResult"];
                var value = dict_Result["CaseResult"];
            var splitStringForCaseNumberArray : [String] = value!.componentsSeparatedByString("/");
            var caseNumberString : String = splitStringForCaseNumberArray[0];
            var theScore = splitStringForCaseNumberArray[1];
            
            
            println("Array Dict Result \(dict_Result) and \(value) and case number from DB \(caseNumberForResultCheck)");
            

            // Now check if element/case number is present in array, if so we knwo this case has been answered and result saved to userdefaults
            
            if(caseNumberD == caseNumberString){
                
                // the csse n this row has ben answered so ste the score label
                
                caseCell.labelScore.text = theScore;
                
                hasResult = true;
                }
            
//            } else if (caseNumberD != caseNumberString && !hasResult
//                ){
//                
//                    //only do this if we dont get a result from caseNo = caseNumString
//                    
//                caseCell.labelScore.text = "...";
//            }
                
                
            } // For dict in array
            
//            for wasCaseAnswered in scoreValueArray{
//                
//                println("Array of casesee ansered index = \(wasCaseAnswered)");
//                
//                var caseFromDictValue = wasCaseAnswered["CaseResult"];
//                
                //var caseFromDictStringSplit = caseFromDictValue.
                
                
                
//                if elementCaseNumber == wasCaseAnswered["CaseResult"]{
                
                    // answered, so we should have a value in array 
                    
                    
                    //let scoreValue = scoreValueArray[element!];
                    
//                    println(scoreValue);
//                    
//                    switch scoreValue {
//                        
//                    case "Study up!":
//                        
//                        caseCell.labelScore.text = scoreValue;
//                        
//                    case "Average!":
//                        
//                        caseCell.labelScore.text = scoreValue;
//                        
//                    case "Excellant!":
//                        caseCell.labelScore.text = scoreValue;
//                        
//                    default:
//                        
//                        caseCell.labelScore.text = "....";
//                        
//                    }// switch
//
                    
                    
                }// if element
                
//            } // for
//            
//        } if let array
        
//                if (element < scoreValueArray.count){
//                    
//                    let scoreValue = scoreValueArray[element!];
//                
//                println(scoreValue);
//            
//            switch scoreValue {
//                
//                case "Study up!":
//                
//                    caseCell.labelScore.text = scoreValue;
//                
//                case "Average!":
//                
//                    caseCell.labelScore.text = scoreValue;
//                
//                case "Excellant!":
//                    caseCell.labelScore.text = scoreValue;
//                
//            default:
//                
//                caseCell.labelScore.text = "....";
//                
//            }// switch
//            
//            }// 2nd let
//        }
        
        //defaults.setValue("Study up!", forKey: "caseResult");
        
        
        
    

        return caseCell
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
        
    }
    
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        // sedn the case number selected to the History vc via tabbed view, first get the row/cell pressed
        
        let indexPath = tableView.indexPathForSelectedRow();
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as CasesTableViewCell;
        
        caseNumberToPAsstoHistory = currentCell.labelCaseNo.text!;
        
        self.performSegueWithIdentifier("ItemDetailsSegue", sender: self);
        
        
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "ItemDetailsSegue"){
            
//            var tabBarC : UITabBarController = segue.destinationViewController as UITabBarController
//            var desView: CaseViewController = tabBarC.viewControllers?.first as CaseViewController
//            
//            var caseIndex = overviewTableView!.indexPathForSelectedRow()!.row
//            var selectedCase = self.cases[caseIndex]
//            
//            desView.caseitem = selectedCase
            
            
            var tabBarC : UITabBarController = segue.destinationViewController as UITabBarController;
            
            var destinationView : History = tabBarC.viewControllers?.first as History;
            
            destinationView.caseNumberSelected = caseNumberToPAsstoHistory;
            
            //initilise new vc and cas as history vc
            
            //var viewcontroller = segue.destinationViewController as History;
            
            // pass the caseNumber we got from didselectRow to Hostory proprty / instance
            
            println("Passing case Number to Hisory: \(caseNumberToPAsstoHistory)");
            
            //viewcontroller.caseNumberSelected = caseNumberToPAsstoHistory;
        }
    }
    
    
    @IBAction func unwindToCasesTableView (sender: UIStoryboardSegue) {
        // self.dismissViewControllerAnimated(true, completion: nil)
    }


}// class

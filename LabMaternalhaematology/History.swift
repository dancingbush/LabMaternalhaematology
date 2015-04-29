//
//  History.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 17/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit

import CoreData


// Globals from Database to use thoughtput app

//// AMLS in pregancy case
var caseNumber = ""; // array of strings from label
var caseSummary = ""
var caseNumberString = ""; // for the global ref to case no used in summry

// History
var historyText = ""
var sex = "";
var APGAR = "";
var temp = "";
var age = "";

// Question 1 images
var question1OptionA = "";
var question1OptionB = "";
var question1OptionC = "";
var question1OptionD = "";
var questoin1Image1 = "";
var questoin1Image1Description = "";
var question1Image2 = "";
var questoin1Image2Description = "";
var question1Image3 = "";
var questoin1Image3Description = "";
var question1Image4 = ""; //optional may not use 4
var questoin1Image4Description = "";
var question1_answer = "";



// Core Lab Data
var wcc = "";
var hgb = "";
var plts = "";
var mcv = "";
var mch = "";
var mchc = "";
var others = ""



// Question 2 of 3 First Multiple choice
var theQuestion2 = "Choose the most appropriate tests."
var question2OptionA = "";
var question2OptionB = "";
var question2OptionC = "";
var question2OptionD = "";
var question2optionA_Selected = " ";
var question2optionB_Selected = " ";
var question2optionC_Selected = "";
var question2optionD_Selected = "";
var question2_answer = "";



// Question 3 what is diagnosis
var theQuestion3 = "What is the Diagnosis?"
var question3OptionA = "";
var question3OptionB = "";
var question3OptionC = " ";
var question3OptionD = "";
var question3_answer = "";

// Summary
var numberOfCorrectANswers = "0";
var numberOfIncorrectAnswers = "0";
var usersAnsersToAllQuestions = "Your Answers: \nQ1: ";
var summary = ""
var ParseCase : Bool = false;





class History: UIViewController {

    // Instances, case from peformSegue in tableview
    
    var caseNumberSelected : String = "";
    
    //Views
    
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var labelAge: UILabel!
    
    @IBOutlet weak var labelSex: UILabel!
    
    @IBOutlet weak var labelTemp: UILabel!
    
    @IBOutlet weak var labelPulse: UILabel!
    
    @IBOutlet weak var labelResperiation: UILabel!
    
    @IBOutlet weak var labelBlooDpressure: UILabel!
    
    @IBOutlet weak var labelAPGAR: UILabel!
    
  
    
    
    @IBOutlet weak var history: UITextView!
    
    
    
    
    
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabBar.
        
        println("History: case number passed from table is : \(caseNumberSelected)");
        
        
        assignglobalVariblesFromDataBase(caseNumberSelected);
        
        history.text = historyText;
        labelAge.text = age;
        labelPulse.text = temp;
        labelAPGAR.text = APGAR;
        labelSex.text = sex;
        
       
    }
    
    func assignglobalVariblesFromDataBase(caseNumber: String){
        
        // fetch query on core data and get data for the case number passed
        
        
        //get case from ie 3/10 as is in cell
        var casenoArray : [String] = caseNumber.componentsSeparatedByString("/");
        
        var theCase = casenoArray[0];
        
        caseNumberString = theCase;
        
        println("Case = \(theCase)");
        
        
        //get context objxt and create a user entry with it
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newEntry2 = NSEntityDescription.insertNewObjectForEntityForName("Case", inManagedObjectContext: context) as NSManagedObject;
        
        
        //Fech request
        var request = NSFetchRequest(entityName: "Case");
        
        var results  = context.executeFetchRequest(request, error: nil);
        
        if results?.count > 0{
            
            
            
        
        for result : AnyObject in results! {
            
            if let caseNum : String = result.valueForKey("caseNumber") as? String{
                
                if (caseNum == theCase){
                    
                    
                    println("Getting Case \(caseNum) from DB");
                    
                    println(result);
                    
                    
                    /* assign to globals
                    Is the case from Parse, if so load the questoin1Image1 etc String and get the image from the String+document directory in the LayoutController2 collection view */
                    

                    
                    historyText = result.valueForKey("history") as String;
                        
                    sex = result.valueForKey("sex") as String;
                    APGAR = result.valueForKey("apgar") as String;
                    temp = result.valueForKey("temperature") as String;
                    age = result.valueForKey("age") as String;
                    
                    // Question 1 images
                    question1OptionA = result.valueForKey("question_image1OptionA") as String;
                    question1OptionB = result.valueForKey("question_image1OptionB") as String;
                    question1OptionC = result.valueForKey("question_image1OptionC") as String;
                    question1OptionD = result.valueForKey("question_image1OptionD") as String;
                    questoin1Image1 = result.valueForKey("question1Image1") as String;
                    questoin1Image1Description = result.valueForKey("q1ImageTitleA") as String;
                    question1Image2 = result.valueForKey("question1Image2") as String;
                    questoin1Image2Description = result.valueForKey("q1ImageTitleB") as String;                  question1Image3 = result.valueForKey("question1Image3") as String;
                    questoin1Image3Description = result.valueForKey("q1ImageTitleC") as String;                    question1Image4 = result.valueForKey("question1Image4") as String; //optional may not use 4
                    questoin1Image4Description = result.valueForKey("q1ImageTitleD") as String;                    question1_answer = result.valueForKey("q1Answer") as String;
                    
                    
                    
                    // Core Lab Data
                    wcc = result.valueForKey("wcc") as String;
                    hgb = result.valueForKey("hgb") as String;
                    plts = result.valueForKey("plts") as String;
                    mcv = result.valueForKey("mcv") as String;
                    mch = result.valueForKey("mch") as String;
                    mchc = result.valueForKey("mchc") as String;
                    others = result.valueForKey("others") as String;
                    
                    
                    
                    // Question 2 of 3 First Multiple choice
                    theQuestion2 = result.valueForKey("theQuestion2")  as String;
                    question2OptionA = result.valueForKey("q2OptionA")  as String;
                    question2OptionB = result.valueForKey("q2OptionB")  as String;
                    question2OptionC = result.valueForKey("q2OptionC")  as String;
                    question2OptionD = result.valueForKey("q2OptionD")  as String;
                    
                    question2optionA_Selected = result.valueForKey("q2OptionADialog")  as String;
                    question2optionB_Selected = result.valueForKey("q2OptionBDialog")  as String;
                    question2optionC_Selected = result.valueForKey("q2OptionCDialog")  as String;
                    question2optionD_Selected = result.valueForKey("q2OptionDDialog")  as String;
                    question2_answer = result.valueForKey("question2Answer")  as String;
                    
                    
                    
                    // Question 3 what is diagnosis
                    theQuestion3 = result.valueForKey("theQuestion3")  as String;
                    question3OptionA = result.valueForKey("question3OptionA")  as String;
                    question3OptionB = result.valueForKey("question3OptionB")  as String;
                    question3OptionC = result.valueForKey("question3OptionC")  as String;
                    question3OptionD = result.valueForKey("question3OptionD")  as String;
                    question3_answer = result.valueForKey("question3Answer")  as String;
                    
                    // Summary
                    summary = result.valueForKey("summary")  as String;
                    
                    //Is the case from Parse, if so load the questoin1Image1 etc String and get the image from the String+document directory in the LayoutController2 collection view
                    
                    ParseCase = result.valueForKey("parsecase") as Bool;
                    

                
                }
            }
            
            }
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    @IBAction func unwindToHistory (sender: UIStoryboardSegue) {
        // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

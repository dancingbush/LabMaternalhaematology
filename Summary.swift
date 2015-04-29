//
//  Summary.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 22/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

/*
We need globals for all user answers, the number pf correct
    number of incorrect

NOTE IF image not fitting the voiew correctly slectes Clip Subviews in Attributes inspector and Aspect Fill

*/

import UIKit

class Summary: UIViewController {
    
    
    
    // Instances
    
    let defaults = NSUserDefaults.standardUserDefaults();
    
    var timer = NSTimer();
    
    
    var theSummary = "";
    
    var theCaseNumber = ""; //get from global
    var result = "";
    var frameNumber = 1; //animations
    var noOfCorrectAnwsers = "";
    //var deaultScoreResults : [String] = [];
    //var deaultScoreResults  = [Dictionary<String, String>](); // save NSSerdefaults in array fr each caseNumber as element to populate tablecell
    
    
    
    //Views
    
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var labelCaseNumber: UILabel!
    
    
    @IBOutlet weak var labelCorrectAnswers: UILabel!
    
    
    @IBOutlet weak var labelInCorrectAnswers: UILabel!
    
    
    
    @IBOutlet weak var labelResult: UILabel!
    
    

    @IBOutlet weak var textFieldSummary: UITextView!
    
    
    @IBOutlet weak var buttonComments: UIBarButtonItem!
    
    
    @IBAction func buttonCommentsAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("segueToComments", sender: self);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set tool ar image
        let toolBarbg = UIImage(named: "Background")
        
        toolBar.setBackgroundImage(toolBarbg, forToolbarPosition: .Bottom, barMetrics: .Default);
        
        // print users answers 
        
        theSummary = summary;
        
        theCaseNumber = caseNumberString; //get from global
        
        if(numberOfCorrectANswers != ""){
            
             noOfCorrectAnwsers = numberOfCorrectANswers;
            
        }else{
            
            noOfCorrectAnwsers = "0";
            numberOfCorrectANswers = "0";
        }
       

        
        println("USERS ANSWERS : \(usersAnsersToAllQuestions)");
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:  Selector ("animate"), userInfo: nil, repeats: true);
        
        
        // USe attribured strings to add to summary
        let labelFont = UIFont(name: "HelveticaNeue-Bold", size: 16)
        
        let labelFont2 = UIFont(name: "HelveticaNeue", size: 14);
        
        let attributes = [NSFontAttributeName : labelFont!]
        
        let attributes2 = [NSFontAttributeName : labelFont2!];
        
        
        var attrString = NSMutableAttributedString(string: "Discussion:\n\n", attributes: attributes)
        
        let userAnswers = NSAttributedString(string: "\n\(usersAnsersToAllQuestions)", attributes : attributes2 );
        
        let newString = NSAttributedString(string: "\n\n\(theSummary)", attributes : attributes2);
        
        //let summaryAndUserAnswers = "\(userAnswers)\n\n\(newString)";
        
        attrString.appendAttributedString(userAnswers);
        
        attrString.appendAttributedString(newString);
        
        
        println(attrString.description)
        
        textFieldSummary.attributedText = attrString;
        
               labelCaseNumber.text = caseNumberString;
        
        labelCorrectAnswers.text = numberOfCorrectANswers;
        
        labelInCorrectAnswers.text = numberOfIncorrectAnswers;
        
        setImageAndResult();
        
        
        // once set the summary must rset userAnserwers so they dont collate
        usersAnsersToAllQuestions = "";
        
        numberOfCorrectANswers = "";
        
        noOfCorrectAnwsers = "";
        
           }
    
    
    
    override func viewDidLayoutSubviews() {
        //before subviews loaded we will hide the image view to the left off screen
        
        self.imageView.frame = CGRectMake(80, 20, 0, 0);
        
        // imageAlien.frame = CGRectMake(80, 20, 0, 0);
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // after views have been downloaded slowlu move image view to center pf screen
        
        //defaults = NSUserDefaults.standardUserDefaults();
        
        UIView.animateWithDuration(3, animations: { () -> Void in
            
            
            // self.imageAlien.frame = CGRectMake(40, 70, 300, 300);
            self.imageView.frame = CGRectMake(0, 75, 320, 150); //x,y,width, height
            
        });
    
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    
    func animate(){
        
        //change image in imageview every time thi fucn called by NSTimer in viewDidlOad, vary image shown according
        // to number of answers correct
        
        
        switch noOfCorrectAnwsers {
            
        case "1":
            
            //  study up
            
            
            if(frameNumber>8){
                
                frameNumber=1;//only have two images to aniamte
            }

            
            let frame2 = UIImage(named: "book\(frameNumber)");
            
            imageView.image = frame2;
            
            frameNumber++;

            
        case "2":
            
            // slam dunk
            
            if(frameNumber>43){
                
                frameNumber=1;//only have two images to aniamte
                
            } else if (frameNumber == 12){
                
                // missing a number
                
                frameNumber = 13;
            } else if (frameNumber == 31){
                
                frameNumber = 32;
            }
            
            
            let frame2 = UIImage(named: "slam\(frameNumber)");
            
            imageView.image = frame2;
            
            frameNumber++;
        
        case "3":
            
            // old people dancing
            
            
            if(frameNumber>2){
                
                frameNumber=1;//only have two images to aniamte
            }

            
            let frame2 = UIImage(named: "oldpeople\(frameNumber)");
            
            imageView.image = frame2;
            
            frameNumber++;

        default:
            
           
            //  must be no questions answered so study up
            
            
            if(frameNumber>8){
                
                frameNumber=1;//only have two images to aniamte
            }
            
            
            let frame2 = UIImage(named: "book\(frameNumber)");
            
            imageView.image = frame2;
            
            frameNumber++;


        }
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func setImageAndResult(){
        
        
        // set text label according to resylt and also save NSUSerDefault to populate the tableview cell of all cases
        
        
        
        // Caete the array for deaults lazily so it will not be overrodden, cant use let here as contants are immutable so will not allow to append 
        
        if var deaultScoreResults : [Dictionary<String, String>]  = defaults.objectForKey("userScoreForCase") as? Array{
            
            // we no array already created so we dont recreate and overwrite the current array
            println("Array OF Case Answeres size : \(deaultScoreResults.count)");
            
            switch noOfCorrectAnwsers {
                
            case "1":
                
                //imageView.image = UIImage(named: "splash");
                
                labelResult.text = "Study Up!";
                
                println("Image set to 1 Correct Answer");
                
                // Insert result for element caseNumber for tablevoew cell, key:value = CaseResul : the Case Number/Result
                
                deaultScoreResults.append(["CaseResult":caseNumberString+"/Study Up!"])
                
                
                
                defaults.setObject(deaultScoreResults, forKey: "userScoreForCase");
                //defaults.setValue("Study up!", forKey: "caseResult");
                
                
            case "2":
                
                //imageView.image = UIImage(named: "pizza");
                
                labelResult.text = "Good!";
                
                println("Image set to 2 Correct Answer");
                
                
                //deaultScoreResults.append("Average!": )
                //deaultScoreResults.insert("Average!", atIndex: caseNumberString.toInt()!);
                
                deaultScoreResults.append(["CaseResult":caseNumberString+"/Average!"])
                
                defaults.setObject(deaultScoreResults, forKey: "userScoreForCase");
                
                //defaults.setValue("Average!!", forKey: "caseResult");
                
                
            case "3":
                
                labelResult.text = "Excellant!";
                
                
                
                
                deaultScoreResults.append(["CaseResult":caseNumberString+"/Excellant!"])
                
                
                defaults.setObject(deaultScoreResults, forKey: "userScoreForCase");
                
                
                //defaults.setValue("Excellant!!", forKey: "caseResult");
                
                
                
            default:
                
                //imageView.image = UIImage(named: "default-placeholder");
                
                labelResult.text = "OMG!- Study!";
                
                println("Image set to 3 Correct Answer");
                
                
                
                // deaultScoreResults.insert("Study Up!", atIndex: caseNumberString.toInt()!);
                
                
                deaultScoreResults.append(["CaseResult":caseNumberString+"/Study Up!"])
                
                defaults.setObject(deaultScoreResults, forKey: "userScoreForCase");
            }
            
        }else {
            
            // we must craete the array
            var deaultScoreResults  = [Dictionary<String, String>]()
        
        
        
        
        switch noOfCorrectAnwsers {
        
        case "1":
            
            //imageView.image = UIImage(named: "splash");
            
            labelResult.text = "Study Up!";
            
            println("Image set to 1 Correct Answer");
            
            // Insert result for element caseNumber for tablevoew cell, key:value = CaseResul : the Case Number/Result
            
            deaultScoreResults.append(["CaseResult":caseNumberString+"/Study Up!"])
            
            
            
           defaults.setObject(deaultScoreResults, forKey: "userScoreForCase");
            //defaults.setValue("Study up!", forKey: "caseResult");
            
            
        case "2":
            
            //imageView.image = UIImage(named: "pizza");
            
            labelResult.text = "Good!";
            
            println("Image set to 2 Correct Answer");
            
            
            //deaultScoreResults.append("Average!": )
            //deaultScoreResults.insert("Average!", atIndex: caseNumberString.toInt()!);
            
           deaultScoreResults.append(["CaseResult":caseNumberString+"/Average!"])
            
            defaults.setObject(deaultScoreResults, forKey: "userScoreForCase");

            //defaults.setValue("Average!!", forKey: "caseResult");
            
            
        case "3":
            
            labelResult.text = "Excellant!";
            
            
            
            
           deaultScoreResults.append(["CaseResult":caseNumberString+"/Excellant!"])
            
            
            defaults.setObject(deaultScoreResults, forKey: "userScoreForCase");

            
            //defaults.setValue("Excellant!!", forKey: "caseResult");
            
            

        default:
            
            //imageView.image = UIImage(named: "default-placeholder");
            
            labelResult.text = "OMG!- Study!";
            
            println("Image set to 3 Correct Answer");
            
            
            
           // deaultScoreResults.insert("Study Up!", atIndex: caseNumberString.toInt()!);
            
            
            deaultScoreResults.append(["CaseResult":caseNumberString+"/Study Up!"])
            
            defaults.setObject(deaultScoreResults, forKey: "userScoreForCase");

            
            
            
            //defaults.setValue("Study up!", forKey: "caseResult");
            
        }// swict
        
        }// else
        
        
               }// setIMage

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

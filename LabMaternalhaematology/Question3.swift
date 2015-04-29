//
//  Question3.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 22/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit

class Question3: UIViewController {
    
    
    
    
    
    //Instances
    var question = "";
    var option1 = "";
    var option2 = "";
    var option3 = "";
    var option4 = "";
    var theAnswer = "";
    var usersGuess = "";
    var isUserAnwserCorrect : Bool = false; //checked in diiplaDalog
    
    
    
    
    
//    // results t display when a button clicked
//    var resultsA = "FVII = 0.25 - Low\nFIX = 0.90 - Norm\nvWF = 2.3 - Norm\nTT = 67s - High";
//    var resultsB = "karyotype XY\nFISH - Normal";
//    var resultsC = "No chromsomal Abnormalities";
//    var resultsD = "BM: Retuclin deposits.\n>80% blasts\nMyelodysplasia\nTrephine: No abnormalities.";
    
    
    
    
    
    //Views
    
    
    @IBOutlet weak var labelQuestion: UILabel!
    
    @IBOutlet weak var buttonAnswer1: UIButton!
    
    
    @IBAction func buttonSelectAnswer1(sender: AnyObject) {
        
        println("ANSWER A CHOSEN");
        
                // if anser correct then change colour of button to grren
        
                usersGuess = "A";
        
        
        
        checkAnswer(usersGuess, button : sender as UIButton); // check anwer
        
        
                
                buttonAnswer1.userInteractionEnabled = false;

        
        
    }
    
    @IBOutlet weak var buttonAnswer2: UIButton!
    
    @IBAction func buttonSelectAnswer2(sender: AnyObject) {
        
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "B";
        
        
        
        checkAnswer(usersGuess, button: sender as UIButton); // check anwer
        
        
        
        buttonAnswer1.userInteractionEnabled = false;
    
    
    }
    
    
    @IBOutlet weak var buttonAnswer3: UIButton!
    
    
    @IBAction func buttonSelectAnswer3(sender: AnyObject) {
        
        usersGuess = "C";
        
        
        
        checkAnswer(usersGuess, button : sender as UIButton); // check anwer
        
        
        
        buttonAnswer1.userInteractionEnabled = false;
        
        
    }
    
    @IBOutlet weak var buttonAnswer4: UIButton!
    
    
    @IBAction func buttonSelectAnswer4(sender: AnyObject) {
        
        usersGuess = "D";
        
        
        
        checkAnswer(usersGuess, button : sender as UIButton); // check anwer
        
        
        
        buttonAnswer1.userInteractionEnabled = false;
        
        
        
    }
    
    
    
    
    func checkAnswer(userGuess : String, button : UIButton){
        
        //when suer clicks button send the guess and dsiplay dialog accrodingly
        
        //var resultToDispaly = "";
        
        
        // check if answer correct or not first, this is only checked once the very fisrt button is pressed, doeb by bool flag
        if (userGuess == theAnswer){
            
            
            // get he anser form button passed
            
            usersAnsersToAllQuestions = usersAnsersToAllQuestions + "\nQ3: \(button.titleLabel!.text!) - Correct!";
            
            
          
            if (numberOfCorrectANswers == "1"){
                
                numberOfCorrectANswers = "2";
                
                
                
            } else if (numberOfCorrectANswers == "0"){
                
                numberOfCorrectANswers = "1";
                
            } else {
                
                numberOfCorrectANswers = "3";
            }

            
            println("CORRECT ANSWER CHOSEN \(userGuess) and aswer is \(theAnswer)");
            
            self.isUserAnwserCorrect = true;
           
            
        } else if (userGuess != theAnswer){
            
            
            // get he anser form button passed
            
            usersAnsersToAllQuestions = usersAnsersToAllQuestions + "\nQ3: \(button.titleLabel!.text!) - InCorrect!";
            
            
            
            if (numberOfIncorrectAnswers == "1"){
                
                numberOfIncorrectAnswers = "2";
                
            } else if (numberOfIncorrectAnswers == "0"){
                
                numberOfIncorrectAnswers = "1";
                
            } else {
                
                numberOfIncorrectAnswers = "3";
            }
            
            
            

            println("INCORRECT ANSWER CHOSEN \(userGuess) should of been \(self.theAnswer)");
            
            self.isUserAnwserCorrect = false;
            
        }
        
//        do?", preferredStyle: .Alert)
        
//        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        var alert = UIAlertController(title: "Finish", message: "Are uou sure?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            action in
            println("Users selected \(self.usersGuess)  as final answer, correct answer is \(self.theAnswer), . Bool anser is correct = \(self.isUserAnwserCorrect), disabling buttons");
            
            self.disableAllButtons();
        
           self.performSegueWithIdentifier("segueToSummary", sender: self);// naviaget to ext view
            
        }));
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            action in
            //nothing required here alow another choice
            
            println("Canvel sletected, user trys again, Bool anser is correct = \(self.isUserAnwserCorrect)");
        }));
        
        
        
        
        
        self.presentViewController(alert, animated: true, completion: nil);
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //set parameters from globals from db query in History
        option1 = question3OptionA;
        option2 = question3OptionB;
        option3 = question3OptionC;
        option4 = question3OptionD;
        theAnswer = question3_answer;
        
        // Set button texts to the options from DB after view has loaded
        
        labelQuestion.text = theQuestion3;
        
        buttonAnswer1.setTitle(option1, forState: UIControlState.Normal);
        
        buttonAnswer2.setTitle(option2, forState: UIControlState.Normal);
        
        buttonAnswer3.setTitle(option3, forState: UIControlState.Normal);
        
        buttonAnswer4.setTitle(option4, forState: UIControlState.Normal);
        
    }
    
    
    
    func disableAllButtons(){
        
        buttonAnswer1.titleLabel?.textColor = UIColor.blueColor();
        buttonAnswer1.enabled = false;
        
         buttonAnswer2.titleLabel?.textColor = UIColor.blueColor();
        buttonAnswer2.enabled = false;
       
        
        buttonAnswer3.titleLabel?.textColor = UIColor.blueColor();
        buttonAnswer3.enabled = false;
        
        
         buttonAnswer4.titleLabel?.textColor = UIColor.blueColor();
        buttonAnswer4.enabled = false;
        
        println("USER NASWER 1 = \(usersAnsersToAllQuestions)\nNO OF CORRECT-IN ANSWER = \(numberOfCorrectANswers) : \(numberOfIncorrectAnswers)");

       
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        println("USER NASWER 1 = \(usersAnsersToAllQuestions)\nNO OF CORRECT-IN ANSWER = \(numberOfCorrectANswers) : \(numberOfIncorrectAnswers)");
    }


}

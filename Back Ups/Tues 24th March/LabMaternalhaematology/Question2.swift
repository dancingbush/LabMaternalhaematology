//
//  Question2.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 22/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit

class Question2: UIViewController {

    

    
    //Instances
    var question = "";
    var option1 = "Factor Studies";
    var option2 = "Krotyping/Cytogentics";
    var option3 = "Chromsomal Studies";
    var option4 = "Bone Marrow/Trephine";
    var theAnswer = "D";
    var usersGuess = "";
    var isUserAnwserCorrect : Bool = false; //checked in diiplaDalog
    var firstButtonAnswerPressed =  false;
    var questionAlreadyAnswered = false;
    
    
    
    
    
    // results t display when a button clicked
    var resultsA = "FVII = 0.25 - Low\nFIX = 0.90 - Norm\nvWF = 2.3 - Norm\nTT = 67s - High";
    var resultsB = "karyotype XY\nFISH - Normal";
    var resultsC = "No chromsomal Abnormalities";
    var resultsD = "BM: Retuclin deposits.\n>80% blasts\nMyelodysplasia\nTrephine: No abnormalities.";
    
    
    
    
    
    //Views
    
    
    @IBOutlet weak var labelQuestion: UILabel!
    
    
    @IBOutlet weak var buttonAnswer1: UIButton!
    
    
    //setTitle("my text here", forState: UIControlState.Normal)
//    buttonAnswer1.setTitle(option1, forState: UIControlState.Normal);
    
    
    @IBAction func buttonSelectAnswer1(sender: AnyObject) {
        
        println("ANSWER A CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "A";
        
        firstButtonAnswerPressed = true;
        
        displayResultsDialog(usersGuess);
        
        

        buttonAnswer1.userInteractionEnabled = false;

        
        
    }
    
    
        @IBOutlet weak var buttonAnswer2: UIButton!
    
    @IBOutlet weak var buttonSelectAnswer2: UIButton!
    
    @IBAction func buttonSelectAnswer2(sender: AnyObject) {
        
        println("ANSWER B CHOSEN");
        //
        //        // if anser correct then change colour of button to grren
        
               usersGuess = "B";
        
        firstButtonAnswerPressed = true;
        
        
               displayResultsDialog(usersGuess);
        
        
        
        buttonAnswer2.userInteractionEnabled = false;
        buttonAnswer2.titleLabel?.textColor = UIColor.grayColor();

        
    }
    
    
    @IBOutlet weak var buttonAnswer3: UIButton!
    

    @IBAction func buttonSelectAnswer3(sender: AnyObject) {
        
        println("ANSWER C CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "C";
        
        firstButtonAnswerPressed = true;
        
        displayResultsDialog(usersGuess);
        
        
        
        buttonAnswer3.userInteractionEnabled = false;
        
        buttonAnswer3.titleLabel?.textColor = UIColor.grayColor();
        
        
    }
    
    @IBOutlet weak var buttonAnswer4: UIButton!
    
    @IBAction func buttonSelectAnswer4(sender: AnyObject) {
        
        println("ANSWER B CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "D";
        
        firstButtonAnswerPressed = true;
        
        displayResultsDialog(usersGuess);
        
        
        
        buttonAnswer4.userInteractionEnabled = false;

        buttonAnswer4.titleLabel?.textColor = UIColor.grayColor();

    }
    
   
    
    
    func displayResultsDialog(userGuess : String){
        
    //when suer clicks button send the guess and dsiplay dialog accrodingly
        
        var resultToDispaly = "";
        
        
        // check if answer correct or not first, this is only checked once the very fisrt button is pressed, doeb by bool flag
        if (firstButtonAnswerPressed && userGuess == theAnswer && !questionAlreadyAnswered){
            
            self.isUserAnwserCorrect = true;
            
            firstButtonAnswerPressed = false;
            
            questionAlreadyAnswered = true;
            
            println("CORRECT ANSWER CHOSEN \(userGuess) and aswer is \(theAnswer)");
            
        } else if (firstButtonAnswerPressed && userGuess != theAnswer && !questionAlreadyAnswered){
            
            println("INCORRECT ANSWER CHOSEN \(userGuess) should of been \(self.theAnswer)");
            
            questionAlreadyAnswered = true;
            
        }
        
        
        switch userGuess{
            
            case  "A":
            
                resultToDispaly = resultsA;
            
            
            
            case "B":
            
                resultToDispaly = resultsB
            
            case "C":
            
            resultToDispaly = resultsC
            
            case "D":
            
            resultToDispaly = resultsD
            
            
        default:
            
            resultToDispaly = "None Picked"
            
            
            
        }
    
    var alert = UIAlertController(title: "Further Results", message: resultToDispaly, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
        
        self.presentViewController(alert, animated: true, completion: nil);
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set button texts to the options from DB after view has loaded
        
        buttonAnswer1.setTitle(option1, forState: UIControlState.Normal);
        
        buttonAnswer2.setTitle(option2, forState: UIControlState.Normal);
        
        buttonAnswer3.setTitle(option3, forState: UIControlState.Normal);
        
        buttonAnswer4.setTitle(option4, forState: UIControlState.Normal);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

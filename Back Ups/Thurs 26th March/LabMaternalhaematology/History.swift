//
//  History.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 17/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit


// Globals from Database to use thoughtput app

var caseNumber = "1";
var caseSummary = "A 4 day old prem Jaundiced."

// History
var historyText = "A term, African-American female neonate, born to a 21-yr-old woman G2P1001, was found to have jaundice at 4 hr after birth. The neonate’s red cells typed B, D positive, while the mother’s red cells typed O, D negative. The mother’s anti-B antibody titer was 256"
var sex = "M";
var APGAR = "5";
var temp = "37";
var age = "4 hours";

// Question 1 images
var question1OptionA = "Foetal Cells/Spheros";
var question1OptionB = "Elliptocytosis";
var question1OptionC = "Neg FMH screen";
var question1OptionD = "Fragmentation";
var questoin1Image1 = "case1a.jpg";
var questoin1Image1Description = "Kleihauer-Bueke";
var question1Image2 = "case1b.jpg";
var questoin1Image2Description = "Romansky x40";
var question1Image3 = "case1c.jpg";
var questoin1Image3Description = "Romansky x40";
var question1Image4 = "case1d.jpg"; //optional may not use 4
var questoin1Image4Description = "Acid Elution";
var question1_answer = "A";



// Core Lab Data
var wcc = "5 - N";
var hgb = "106 - L";
var plts = "400 - H";
var mcv = "120 - L";
var mch = "26 - N";
var mchc = "395 - H";
var others = "key: N = Normal\nH= High\nL = Low\n SI units used.\nTotal Bilirubin = 320 - H"



// Question 2 of 3 First Multiple choice 
var theQuestion2 = "Choose the most appropriate tests."
var question2OptionA = "Bilirubin and DAT";
var question2OptionB = "Sickle Screen";
var question2OptionC = "G6PDH Screen";
var question2OptionD = "Pyruvate Kinase screen";
var question2optionA_Selected = "The direct antiglobulin test (DAT) is positive with the cord red cells, and anti-B, but not anti-A, antibody was detected in the neonatal red cell eluate.";
var question2optionB_Selected = "Sickle screen inapproiate in the newborn due to interference of high HbF.\n However haemoglobinopathy screen via HPLC showed:\nHbA = 20% \nHbF = 75%";
var question2optionC_Selected = "Negative";
var question2optionD_Selected = "Negative";
var question2_answer = "A";



// Question 3 what is diagnosis
var theQuestion3 = "What is the Diagnosis?"
var question3OptionA = "Rhesus HDN";
var question3OptionB = "TAM";
var question3OptionC = "ABO HDN";
var question3OptionD = "Sepsis";
var question3_answer = "C";

// Summary
var numberOfCorrectANswers = "0";
var numberOfIncorrectAnswers = "0";
var usersAnsersToAllQuestions = "Your Answers: \nQ1: ";
var summary = "Microscopy demonstrated foetal cells in a kleiahuer bueke, perpherial blood smear demosntarted spherocytosis and polychromasia, indicative of increased RBC turn over due to extravascular haemolysis. \n\n\nThe patient was diagnosed as hemo- lytic disease of the newborn due to ABO incom- patibility (ABO-HDN). The infant’s TB peaked at 16.1 mg/dl on day three (Fig. 2), which prompted 2 sessions of phototherapy and the transfusion of 30 ml of red blood cells. \n\nExchange transfusion was not required. \n\nThe infant was discharged on day 8 with a TB of 3.9 mg/dl.A maternal high titer (> or =64) of anti-Di(b) is associated with a higher risk of severe hyperbilirubinemia for mismatched newborns.\n\nThe neonatal blood smear showed changes typical of hemolysis (Fig.1). Inherited causes, such as G6PD deficiency and sickle cell disease, were excluded. Congenital infection screen- ing tests were negative. No other causes of transient or severe hemolysis could be identified.\n\n ABO-HDN is a common condition occurring in about 15% of infants with A or B blood types born to blood type O mothers and, unlike non- HDN-ABO incompatibility, usually a problem of the neonate rather than of the fetus.\n\nHydrops fetalis in association with ABO incompatibility is extremely rare [4-8], mainly because anti-ABO antibodies are typically IgM and do not cross the placenta. \n\nAdditionally, when IgG anti-A,B, -A, or -B antibodies are produced, ABO antigens on fetal tissues act as a sink for circulating maternal anti- bodies.\n\nFinally, A and B antigens are only weakly expressed on neonatal RBCs.\n ABO-HDN is there- fore usually mild and characterized by a negative or weakly positive DAT. ABO-HDN rarely requires red cell exchange transfusion, in contrast to HDN due to anti-D or other antibodies.  "



class History: UIViewController {

    
    
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
        
        
        history.text = historyText;
        labelAge.text = age;
        labelPulse.text = temp;
        labelAPGAR.text = APGAR;
        labelSex.text = sex;
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//
//  History.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 17/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit


// Globals from Database to use thoughtput app

//// AMLS in pregancy case
var caseNumber = "2";
var caseSummary = "20week G1P0 with hepatospleenomegaly."

// History
var historyText = "A 22yo G1P0 female presented to ER with amenorrhea, pyrexia, anaemia, and a rash over her limbs.\n\nExamination revealed pallor, peteciae,  hepto-spleenomegaly,  and a enlarged uterus corresponding to appox 20weeks of gestation (confirmed via ultra sound).\n\nPatient had a miscarriage at 12 weeks one year previously.\nNo significant family or personal history noted."
var sex = "F";
var APGAR = "NA";
var temp = "39";
var age = "22yo";

// Question 1 images
var question1OptionA = "Megakaryoblasts";
var question1OptionB = "Monoblasts";
var question1OptionC = "Erythroblasts";
var question1OptionD = "Myeloblasts";
var questoin1Image1 = "case2a.jpg";
var questoin1Image1Description = "Romanasky x100";
var question1Image2 = "case2b.jpg";
var questoin1Image2Description = "Romanasky x100";
var question1Image3 = "case2c.jpg";
var questoin1Image3Description = "Romanasky x100";
var question1Image4 = "case2d.jpg"; //optional may not use 4
var questoin1Image4Description = "Romanasky x100";
var question1_answer = "D";



// Core Lab Data
var wcc = "2.4 - N";
var hgb = "48 - L";
var plts = "8 - H";
var mcv = "100 - L";
var mch = "26 - N";
var mchc = "355 - H";
var others = "key: N = Normal\nH= High\nL = Low\n SI units used.\nUrea 16 - H \nCreatinine  42 umol/L – N\nAST 140 U/dl - H\nALP 676 U/dl - H\nLDH 1083 mg/dl – H\nTBIL Bil 1.31mg/dl - H"



// Question 2 of 3 First Multiple choice
var theQuestion2 = "Choose the most appropriate tests."
var question2OptionA = "ASXL1-TET2 mutations";
var question2OptionB = "B12 and Folate";
var question2OptionC = "BM Biopsy + Flow";
var question2OptionD = "JAK2-BCR/ABL gene";
var question2optionA_Selected = " Negative. \nThese RNA splicing mutations are generally used in investigation of myelodysplastic syndromes";
var question2optionB_Selected = " Folate 8.56 – Low, B12 Normal";
var question2optionC_Selected = "BM examination revealed 75% non-erythoid blasts with high/nuclear cytoplasmic ratio, which demonstrated positivity with Sudan Black and Myeloperoxidase and were negative for periodic acid-Schiff.\n\nBlasts were of Type 1 (agruanlar) and Type II (granular). \nApproximately 10% of remaining non-erythoid cells were maturing granulocytes. \nFlow cytometry analysis with a Beckman Coulter Cytomics F500 showed the blasts population was positive for CD13, CD33, CD34 and CD11/CD14/36/64/68 negative.\n\nCytogenetic’s revealed a normal XX type.";
var question2optionD_Selected = "Negative. \nJAK2 and BCR/ABL fusion genes are used investigating of Myeloproliferative disorders ie CML, ET, PRV.";
var question2_answer = "C";



// Question 3 what is diagnosis
var theQuestion3 = "What is the Diagnosis?"
var question3OptionA = "Pure Erythroid Leukemia";
var question3OptionB = "AML –M5 Monblastic";
var question3OptionC = "AML – M2 ";
var question3OptionD = "Acute Basophilic Luekemia";
var question3_answer = "C";

// Summary
var numberOfCorrectANswers = "0";
var numberOfIncorrectAnswers = "0";
var usersAnsersToAllQuestions = "Your Answers: \nQ1: ";
var summary = "AML M6 and M5 (erythoid and Monocytic) are PAS (periodic acid-Schiff)  negative. \n\nMonocytic AML will demonstrate CD11/CD14/36/64/68 positivity.\n\nPure erythoid luekmia (AML M6 FAB) will demonstrate  a HLD-DR+/-, CD34-, CD71+ flow profile.\n\nAcute Basophilic Luekaemia (WHO classification) – very rare and occurs as an end stage leukaemia in less than 1% of all cases of CML. \n\nThis patient had AML M2 ( FAB classification), the WHO equivalent Acute myeloblastic leukaemia with maturation.\n\nThe Patient received induction chemotherapy (3 + 7 regimen) with Daunorubicin 60 mg/m2 /day x 3 days and cytosine arabinoside 200mg/m2 /D x 7 days as continuous infusion. \nPost induction 2 weeks a marrow was performed which was found to be very hypocellular.  A repeat in 2 weeks show complete remission and a normal cellular marrow.\nShe delivered a healthy female newborn with no signs of disease or congenital defects. Post delivery she then received 3 courses of consolidation chemotherapy using high dose cyosine arabinoside.\n\nLeukemia in pregnancy occurs in approx 1 in 10000 pregnancies.\nThe decision to introduce or postpone chemotherapy must be balanced against the impact on maternal and fetal survival and morbidity.\nAL diagnosed in first trimester invariably necessitates chemotherapy and is likely to result in foetal malformations.  Conversely, AL diagnosed in the second trimester does not necessarily  require termination and treatment is similar to those of nongravid patients.\n\nThe outcome of gravid women diagnosed with AL appears to be worse than that of their age-matched non gravid counterparts. However, the survival rate of fetuses exposed to chemotherapy is encouraging and the incidence of malformations and low birth weights for gestation is low. \n\nSummary: \n- Blasts should not be catergorized according to morphology alone, flow +/- special staining must be used.\n-AML in pregnancy has a poorer prognosis relative to AML in non pregnant patients.\n-The decision to introduce or postpone chemotherapy must be balanced against the impact on maternal and fetal survival and morbidity.\n\n\nBibliography\n1. Israel Henig, M. (2013). Acute Myeloid Leukemia Diagnosed During Pregnancy: Facing Challenges. Systematic Review and Analysis Of 174 Reported Cases. Blood , 121.\n\n2.Jeelani S, R. J. (2008). Pregnancy with acute myeloid leukemia. Indian J Med Paediatr Oncol , 29:47-8.\n\n3. Rozenberg, G. (2003). Microscopic Haematology. Melbourne: MD martin Dunitz."


// Jaundcie case


//var caseNumber = "1";
//var caseSummary = "A 4 day old prem Jaundiced."
//
//// History
//var historyText = "A term, African-American female neonate, born to a 21-yr-old woman G2P1001, was found to have jaundice at 4 hr after birth. The neonate’s red cells typed B, D positive, while the mother’s red cells typed O, D negative. The mother’s anti-B antibody titer was 256"
//var sex = "M";
//var APGAR = "5";
//var temp = "37";
//var age = "4 hours";
//
//// Question 1 images
//var question1OptionA = "Foetal Cells/Spheros";
//var question1OptionB = "Elliptocytosis";
//var question1OptionC = "Neg FMH screen";
//var question1OptionD = "Fragmentation";
//var questoin1Image1 = "case1a.jpg";
//var questoin1Image1Description = "Kleihauer-Betke";
//var question1Image2 = "case1b.jpg";
//var questoin1Image2Description = "Romanasky x40";
//var question1Image3 = "case1c.jpg";
//var questoin1Image3Description = "Romansky x40";
//var question1Image4 = "case1d.jpg"; //optional may not use 4
//var questoin1Image4Description = "Acid Elution";
//var question1_answer = "A";
//
//
//
//// Core Lab Data
//var wcc = "5 - N";
//var hgb = "106 - L";
//var plts = "400 - H";
//var mcv = "120 - L";
//var mch = "26 - N";
//var mchc = "395 - H";
//var others = "key: N = Normal\nH= High\nL = Low\n SI units used.\nTotal Bilirubin = 320 - H"
//
//
//
//// Question 2 of 3 First Multiple choice 
//var theQuestion2 = "Choose the most appropriate tests."
//var question2OptionA = "Bilirubin and DAT";
//var question2OptionB = "Sickle Screen";
//var question2OptionC = "G6PDH Screen";
//var question2OptionD = "Pyruvate Kinase screen";
//var question2optionA_Selected = "The direct antiglobulin test (DAT) is positive with the cord red cells, and anti-B, but not anti-A, antibody was detected in the neonatal red cell eluate.";
//var question2optionB_Selected = "Sickle screen inapproiate in the newborn due to interference of high HbF.\n However haemoglobinopathy screen via HPLC showed:\nHbA = 20% \nHbF = 75%";
//var question2optionC_Selected = "Negative";
//var question2optionD_Selected = "Negative";
//var question2_answer = "A";
//
//
//
//// Question 3 what is diagnosis
//var theQuestion3 = "What is the Diagnosis?"
//var question3OptionA = "Rhesus HDN";
//var question3OptionB = "TAM";
//var question3OptionC = "ABO HDN";
//var question3OptionD = "Sepsis";
//var question3_answer = "C";
//
//// Summary
//var numberOfCorrectANswers = "0";
//var numberOfIncorrectAnswers = "0";
//var usersAnsersToAllQuestions = "Your Answers: \nQ1: ";
//var summary = "Microscopy demonstrated foetal cells in a kleiahuer bueke, perpherial blood smear demosntarted spherocytosis and polychromasia, indicative of increased RBC turn over due to extravascular haemolysis. \n\n\nThe patient was diagnosed as hemo- lytic disease of the newborn due to ABO incom- patibility (ABO-HDN). The infant’s TB peaked at 16.1 mg/dl on day three (Fig. 2), which prompted 2 sessions of phototherapy and the transfusion of 30 ml of red blood cells. \n\nExchange transfusion was not required. \n\nThe infant was discharged on day 8 with a TB of 3.9 mg/dl.A maternal high titer (> or =64) of anti-Di(b) is associated with a higher risk of severe hyperbilirubinemia for mismatched newborns.\n\nThe neonatal blood smear showed changes typical of hemolysis (Fig.1). Inherited causes, such as G6PD deficiency and sickle cell disease, were excluded. Congenital infection screen- ing tests were negative. No other causes of transient or severe hemolysis could be identified.\n\n ABO-HDN is a common condition occurring in about 15% of infants with A or B blood types born to blood type O mothers and, unlike non- HDN-ABO incompatibility, usually a problem of the neonate rather than of the fetus.\n\nHydrops fetalis in association with ABO incompatibility is extremely rare [4-8], mainly because anti-ABO antibodies are typically IgM and do not cross the placenta. \n\nAdditionally, when IgG anti-A,B, -A, or -B antibodies are produced, ABO antigens on fetal tissues act as a sink for circulating maternal anti- bodies.\n\nFinally, A and B antigens are only weakly expressed on neonatal RBCs.\n ABO-HDN is there- fore usually mild and characterized by a negative or weakly positive DAT. ABO-HDN rarely requires red cell exchange transfusion, in contrast to HDN due to anti-D or other antibodies.  "
//


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

//
//  LogInViewController.swift
//  iEnvato
//
//  Created by Daniel Sattler on 17.01.15.
//  Copyright (c) 2015 DA-3D. All rights reserved.
//

// Code that manages everything LogIn related

import UIKit
import CoreData


// Globas

var currentUserName = "";

var isARegsiteredUser : Bool = false;

class LogInViewController: UIViewController {
    

    /*Manage ransistions*/
    let transitionManager = TransistionManager();
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var loader: UIActivityIndicatorView! // Activity Indicator that appears when submit button is pressed
    
    @IBOutlet weak var userNameTextField: UITextField!  // Text Field for the Users Name
    
    @IBOutlet weak var apiKeyTextField: UITextField!    // Text Field for the Users API Key
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func submitButton(sender: AnyObject) {    // Action for the Submit Button
        
        
        // check ofor internet connection, if noone deipslay dioalog
        
        if Reachability.isConnectedToNetwork() == true {
            
            println("Internet connection established");
               var password = "myPassword";
        
        println("Button Pressed");
        
        // Once the submit button is pressed, disable it so user can´t tap several times
        // Then show the activity indicator and make it spin while loading the data from envato
        //self.button.enabled = false
       
        
        
        startLoader(true);

        
        self.view.backgroundColor = UIColor.blackColor()

        
        // chekc if paswod is input
        
        if(apiKeyTextField.text == nil && apiKeyTextField.text==""){
            
            println("No password entered");
            
            
            
        }else{
            
            password = apiKeyTextField.text;
            
            println("Password entered: \(password)");
        }
        
        
        if (userNameTextField.text != ""){
            
            currentUserName = userNameTextField.text;
            
            var user = PFUser()
            user.username = userNameTextField.text;
            user.password = password;
            //        user.email = "email@example.com"
            //        // other fields can be set just like with PFObject
            //        user["phone"] = "415-392-0202"
            
            user.signUpInBackgroundWithBlock {
                
                (succeeded: Bool!, error: NSError!) -> Void in
                
                if error == nil {
                    
                    // Hooray! Let them use the app now.
                    
                    println("signed up new user! : \(self.userNameTextField.text)");
                    
                    //self.startLoader(false);
                    
                    
                    
                   self.performSegueWithIdentifier("segueToLMainMenu", sender: self);
                    
                } else {
                    
                    // Log them in if their username aready exost
                    
                    isARegsiteredUser = true;
                    
                    let errorString = error.userInfo!["error"] as NSString
                    
                    println("Cant sign up so logging this user \(self.userNameTextField.text) in: \(errorString)");
                    
                    
                    PFUser.logInWithUsernameInBackground(self.userNameTextField.text, password:password) {
                        
                        (user: PFUser!, error: NSError!) -> Void in
                        
                        if user != nil {
                            // Do stuff after successful login.
                            
                            println("LOGGED IN!");
                            
                            //self.performSegueWithIdentifier("segueLogInToTableView", sender: self);
                            
                            self.startLoader(false);
                            
                            self.performSegueWithIdentifier("segueToLMainMenu", sender: self);
                            
                            
                        } else {
                            // The login failed. Check error to see why.
                            
                            let theError  = error.userInfo!["error"] as NSString;
                            
                            println("Log in Failed: \(theError)");
                            
                            
                            
                            self.startLoader(false);
                            
                            // this will only happen if a user who is already in parse is logging on to a new devicw
                            self.displayAlert("Log In Error", message: "Opps! Username already In use. Try again.");
                        }
                    }
                }
            }
            
        } else {
            
            displayAlert("Alert", message: "Please Enter a Username");
            
            
        }

        
        } else if (Reachability.isConnectedToNetwork() == false) {
            
            println("No wifi or 3g detecetd");
            
            displayAlert("Wi-Fi/3G", message: "No internet connection detected...please try againg later.")
            
        }


    } // method button pressed
    
    
    override func viewDidAppear(animated: Bool) {
        // When the Screen Shows Up or the App is Loaded, check id there is some User Data stored in the Apps Cache.
        // If so, load them.
        
        
        if(PFUser.currentUser() != nil){
            
            isARegsiteredUser = true;
            
            currentUserName = PFUser.currentUser().username;
            
            
            
            self.performSegueWithIdentifier("segueToLMainMenu", sender: self);
        }
           }
    
    
    
    func displayAlert(title : String, message : String){
        
        //self.loader.stopAnimating();
        
        var alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // When the Screen Shows Up or the App is Loaded, check id there is some User Data stored in the Apps Cache.
        
        // create the loader, called in sepreate func
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        
        
        var caseLoadedToCoreData : Bool;
        
        // check of data already loaded to core 
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let caseLoadedToCoreDataTest = defaults.boolForKey("casesLoadedToCore") as Bool?
        {
            
            
            
            caseLoadedToCoreData = true;
            
            println("Cases already loaded : \(caseLoadedToCoreData)");
            
            
        }else{
            
            caseLoadedToCoreData = false;
        
        }
        
        
        if (!caseLoadedToCoreData){
            
            
            
            
        // set up database
        //get context objxt and create a user entry with it
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newEntry2 = NSEntityDescription.insertNewObjectForEntityForName("Case", inManagedObjectContext: context) as NSManagedObject; // enity = the table name whoch is TableName in this case
        
//        context.deletedObjects;
//        var error : NSError? = nil;
//
//        context.save(&error);
        
//        From this point on, any changes you make to your Core Data model, such as adding a new Entity or Attribute will lead to an inconsistency in the model of the app in the iPhone Simulator. If this happens to you, you’ll get a really scary looking crash in your app as soon as it starts. You’ll also see something like this show up at the very bottom of your console, “reason=The model used to open the store is incompatible with the one used to create the store”.
//        
//        If this happens to you there is a very easy fix:
//        In the iPhone Simulator, or on your device, just delete the app, and then perform a new Build & Run command in Xcode. This will erase all out of date versions of the model, and allow you to do a fresh run.
        
        

        // do this just once as the entry will besaved as new entry everytme we run the app
        
        // n= 44 attributes PAGR >8 = good Appernce, pulse , grimace, actvity
        
        // data for jauncide case
        
        newEntry2.setValue("1", forKey: "caseNumber");
        newEntry2.setValue("Jaundiced newborn.", forKey: "caseSummary");
        newEntry2.setValue("A term, African-American female neonate, born to a 21-yr-old woman G2P1001, was found to have jaundice at 4 hr after birth. The neonate’s red cells typed B, D positive, while the mother’s red cells typed O, D negative. The mother’s anti-B antibody titer was 256", forKey: "history");
        newEntry2.setValue("M", forKey: "sex");
        newEntry2.setValue("4 hrs", forKey: "age");
        newEntry2.setValue("8", forKey: "apgar");
        newEntry2.setValue("37.1", forKey: "temperature");
        newEntry2.setValue("5 - N", forKey: "wcc");
        newEntry2.setValue("106 - L", forKey: "hgb");
        newEntry2.setValue("26 - N", forKey: "mch");
        newEntry2.setValue("395 - H", forKey: "mchc");
        newEntry2.setValue("120 - L", forKey: "mcv");
        newEntry2.setValue("400 - H", forKey: "plts");
        newEntry2.setValue("key: N = Normal\nH= High\nL = Low\n SI units used.\nTotal Bilirubin = 320 - H", forKey: "others");
        newEntry2.setValue("Kleihauer-Betke", forKey: "q1ImageTitleA");
        newEntry2.setValue("Romanasky x40", forKey: "q1ImageTitleB");
        newEntry2.setValue("Romanasky x40", forKey: "q1ImageTitleC");
        newEntry2.setValue("Acid Elution", forKey: "q1ImageTitleD");
        newEntry2.setValue("case1a.jpg", forKey: "question1Image1");
        newEntry2.setValue("case1b.jpg", forKey: "question1Image2");
        newEntry2.setValue("case1c.jpg", forKey: "question1Image3");
        newEntry2.setValue("case1d.jpg", forKey: "question1Image4");
        newEntry2.setValue("Foetal Cells/Spheros", forKey: "question_image1OptionA");
        newEntry2.setValue("Elliptocytosis", forKey: "question_image1OptionB");
        newEntry2.setValue("Neg FMH screen", forKey: "question_image1OptionC");
        newEntry2.setValue("Fragmentation", forKey: "question_image1OptionD");
        newEntry2.setValue("A", forKey: "q1Answer");
        
        newEntry2.setValue("Select most appropriate tests", forKey: "theQuestion2");
        newEntry2.setValue("TBili & DAT", forKey: "q2OptionA");
        newEntry2.setValue("Sickle Screen", forKey: "q2OptionB");
        newEntry2.setValue("G6PDH Screen", forKey: "q2OptionC");
        newEntry2.setValue("Pyruvate Kinase", forKey: "q2OptionD");
        newEntry2.setValue("The direct antiglobulin test (DAT) is positive with the cord red cells, and anti-B, but not anti-A, antibody was detected in the neonatal red cell eluate.", forKey: "q2OptionADialog");
        newEntry2.setValue("Sickle screen inapproiate in the newborn due to interference of high HbF.\n However haemoglobinopathy screen via HPLC showed:\nHbA = 20% \nHbF = 75%", forKey: "q2OptionBDialog");
        newEntry2.setValue("Negative", forKey: "q2OptionCDialog");
        newEntry2.setValue("Negative", forKey: "q2OptionDDialog");
        newEntry2.setValue("A", forKey: "question2Answer");
        
        newEntry2.setValue("What is Diagnosis?", forKey: "theQuestion3");
        newEntry2.setValue("Rhesus HDN", forKey: "question3OptionA");
        newEntry2.setValue("TAM", forKey: "question3OptionB");
        newEntry2.setValue("ABO HDN", forKey: "question3OptionC");
        newEntry2.setValue("Sepsis", forKey: "question3OptionD");
        newEntry2.setValue("C", forKey: "question3Answer");
        
        newEntry2.setValue("Microscopy demonstrated foetal cells in a kleiahuer bueke, perpherial blood smear demosntarted spherocytosis and polychromasia, indicative of increased RBC turn over due to extravascular haemolysis. \n\n\nThe patient was diagnosed as hemo- lytic disease of the newborn due to ABO incom- patibility (ABO-HDN). The infant’s TB peaked at 16.1 mg/dl on day three (Fig. 2), which prompted 2 sessions of phototherapy and the transfusion of 30 ml of red blood cells. \n\nExchange transfusion was not required. \n\nThe infant was discharged on day 8 with a TB of 3.9 mg/dl.A maternal high titer (> or =64) of anti-Di(b) is associated with a higher risk of severe hyperbilirubinemia for mismatched newborns.\n\nThe neonatal blood smear showed changes typical of hemolysis (Fig.1). Inherited causes, such as G6PD deficiency and sickle cell disease, were excluded. Congenital infection screen- ing tests were negative. No other causes of transient or severe hemolysis could be identified.\n\n ABO-HDN is a common condition occurring in about 15% of infants with A or B blood types born to blood type O mothers and, unlike non- HDN-ABO incompatibility, usually a problem of the neonate rather than of the fetus.\n\nHydrops fetalis in association with ABO incompatibility is extremely rare [4-8], mainly because anti-ABO antibodies are typically IgM and do not cross the placenta. \n\nAdditionally, when IgG anti-A,B, -A, or -B antibodies are produced, ABO antigens on fetal tissues act as a sink for circulating maternal anti- bodies.\n\nFinally, A and B antigens are only weakly expressed on neonatal RBCs.\n ABO-HDN is there- fore usually mild and characterized by a negative or weakly positive DAT. ABO-HDN rarely requires red cell exchange transfusion, in contrast to HDN due to anti-D or other antibodies.\n\nBibliography\n\n1. Rozenberg, G. (2003). Microscopic Haematology. Melbourne: MD martin Dunitz.", forKey: "summary");
        
        newEntry2.setValue(false, forKey: "parsecase");
        
//
//        // entry for AML in PRgenancys
//        
//        //template for entry
        
         var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("Case", inManagedObjectContext: context) as NSManagedObject;
        
        
        newEntry3.setValue("2", forKey: "caseNumber");
        newEntry3.setValue("20week G1P0 with hepatospleenomegaly", forKey: "caseSummary");
        newEntry3.setValue("A 22yo G1P0 female presented to ER with amenorrhea, pyrexia, anaemia, and a rash over her limbs.\n\nExamination revealed pallor, peteciae,  hepto-spleenomegaly,  and a enlarged uterus corresponding to appox 20weeks of gestation (confirmed via ultra sound).\n\nPatient had a miscarriage at 12 weeks one year previously.\nNo significant family or personal history noted.", forKey: "history");
        newEntry3.setValue("F", forKey: "sex");
        newEntry3.setValue("22yo", forKey: "age");
        newEntry3.setValue("N/A", forKey: "apgar");
        newEntry3.setValue("39", forKey: "temperature");
        newEntry3.setValue("2.4 - N", forKey: "wcc");
        newEntry3.setValue("48 - L", forKey: "hgb");
        newEntry3.setValue("26 - N", forKey: "mch");
        newEntry3.setValue("355 -N", forKey: "mchc");
        newEntry3.setValue("100 - H", forKey: "mcv");
        newEntry3.setValue("8 - L", forKey: "plts");
        newEntry3.setValue("key: N = Normal\nH= High\nL = Low\n SI units used.\nUrea 16 - H \nCreatinine  42 umol/L – N\nAST 140 U/dl - H\nALP 676 U/dl - H\nLDH 1083 mg/dl – H\nTBIL Bil 1.31mg/dl - H", forKey: "others");
        newEntry3.setValue("Romanowsky x100", forKey: "q1ImageTitleA");
        newEntry3.setValue("Romanowsky x100", forKey: "q1ImageTitleB");
        newEntry3.setValue("Romanowsky x100", forKey: "q1ImageTitleC");
        newEntry3.setValue("Romanowsky x100", forKey: "q1ImageTitleD");
        newEntry3.setValue("case2a.jpg", forKey: "question1Image1");
        newEntry3.setValue("case2b.jpg", forKey: "question1Image2");
        newEntry3.setValue("case2c.jpg", forKey: "question1Image3");
        newEntry3.setValue("case2d.jpg", forKey: "question1Image4");
        newEntry3.setValue("Megakaryoblasts", forKey: "question_image1OptionA");
        newEntry3.setValue("Monoblasts", forKey: "question_image1OptionB");
        newEntry3.setValue("Erythroblasts", forKey: "question_image1OptionC");
        newEntry3.setValue("Blasts", forKey: "question_image1OptionD");
        newEntry3.setValue("D", forKey: "q1Answer");
        
        
        newEntry3.setValue("Select most appropriate tests", forKey: "theQuestion2");
        
        newEntry3.setValue("ASXL1-TET2 mutations", forKey: "q2OptionA");
        newEntry3.setValue("B12 and Folate", forKey: "q2OptionB");
        newEntry3.setValue("BM Biopsy + Flow", forKey: "q2OptionC");
        newEntry3.setValue("JAK2-BCR/ABL gene", forKey: "q2OptionD");
        newEntry3.setValue("Negative. \nThese RNA splicing mutations are generally used in investigation of myelodysplastic syndromes", forKey: "q2OptionADialog");
        newEntry3.setValue("Folate 8.56 – Low, B12 Normal", forKey: "q2OptionBDialog");
        newEntry3.setValue("BM examination revealed 75% non-erythoid blasts with high/nuclear cytoplasmic ratio, which demonstrated positivity with Sudan Black and Myeloperoxidase and were negative for periodic acid-Schiff.\n\nBlasts were of Type 1 (agruanlar) and Type II (granular). \nApproximately 10% of remaining non-erythoid cells were maturing granulocytes. \nFlow cytometry analysis with a Beckman Coulter Cytomics F500 showed the blasts population was positive for CD13, CD33, CD34 and CD11/CD14/36/64/68 negative.\n\nCytogenetic’s revealed a normal XX type.", forKey: "q2OptionCDialog");
        newEntry3.setValue("Negative. \nJAK2 and BCR/ABL fusion genes are used investigating of Myeloproliferative disorders ie CML, ET, PRV.", forKey: "q2OptionDDialog");
        
        newEntry3.setValue("C", forKey: "question2Answer");
        
        newEntry3.setValue("What is the Diagnosis?", forKey: "theQuestion3");
        newEntry3.setValue("Pure Erythroid Leuk", forKey: "question3OptionA");
        newEntry3.setValue("AML –M5 Monblastic", forKey: "question3OptionB");
        newEntry3.setValue("AML – M2", forKey: "question3OptionC");
        newEntry3.setValue("Acute Basophilic Luek", forKey: "question3OptionD");
        
        newEntry3.setValue("C", forKey: "question3Answer");
        newEntry3.setValue("AML M6 and M5 (erythoid and Monocytic) are PAS (periodic acid-Schiff)  negative. \n\nMonocytic AML will demonstrate CD11/CD14/36/64/68 positivity.\n\nPure erythoid luekmia (AML M6 FAB) will demonstrate  a HLD-DR+/-, CD34-, CD71+ flow profile.\n\nAcute Basophilic Luekaemia (WHO classification) – very rare and occurs as an end stage leukaemia in less than 1% of all cases of CML. \n\nThis patient had AML M2 ( FAB classification), the WHO equivalent Acute myeloblastic leukaemia with maturation.\n\nThe Patient received induction chemotherapy (3 + 7 regimen) with Daunorubicin 60 mg/m2 /day x 3 days and cytosine arabinoside 200mg/m2 /D x 7 days as continuous infusion. \nPost induction 2 weeks a marrow was performed which was found to be very hypocellular.  A repeat in 2 weeks show complete remission and a normal cellular marrow.\nShe delivered a healthy female newborn with no signs of disease or congenital defects. Post delivery she then received 3 courses of consolidation chemotherapy using high dose cyosine arabinoside.\n\nLeukemia in pregnancy occurs in approx 1 in 10000 pregnancies.\nThe decision to introduce or postpone chemotherapy must be balanced against the impact on maternal and fetal survival and morbidity.\nAL diagnosed in first trimester invariably necessitates chemotherapy and is likely to result in foetal malformations.  Conversely, AL diagnosed in the second trimester does not necessarily  require termination and treatment is similar to those of nongravid patients.\n\nThe outcome of gravid women diagnosed with AL appears to be worse than that of their age-matched non gravid counterparts. However, the survival rate of fetuses exposed to chemotherapy is encouraging and the incidence of malformations and low birth weights for gestation is low. \n\nSummary: \n- Blasts should not be catergorized according to morphology alone, flow +/- special staining must be used.\n-AML in pregnancy has a poorer prognosis relative to AML in non pregnant patients.\n-The decision to introduce or postpone chemotherapy must be balanced against the impact on maternal and fetal survival and morbidity.\n\n\nBibliography\n1. Israel Henig, M. (2013). Acute Myeloid Leukemia Diagnosed During Pregnancy: Facing Challenges. Systematic Review and Analysis Of 174 Reported Cases. Blood , 121.\n\n2.Jeelani S, R. J. (2008). Pregnancy with acute myeloid leukemia. Indian J Med Paediatr Oncol , 29:47-8.\n\n3. Rozenberg, G. (2003). Microscopic Haematology. Melbourne: MD martin Dunitz.", forKey: "summary");

        newEntry3.setValue(false, forKey: "parsecase");
        
       
        var error : NSError? = nil;
////
//         //save to DB and handle error if present
//        
       context.save(&error);
        
        
        // Set user defualts as saved to true 
        
     
            defaults.setObject(true, forKey: "casesLoadedToCore");
       

        
            
        }// if !caseLoadedToCoreData

//
//        
//        
//        
//        // GET DATA FTOM DB
//         var request = NSFetchRequest(entityName: "Case");
////        //var request = NSFetchRequest(entityName: "Cases"); // enoty = table name
////        
////         
//        // for beta 4 xcode only
////        request.returnsObjectsAsFaults = false;
////        
////        
////        // do a search, thos will return a results array with search results only!
////        //request.predicate = NSPredicate(format: <#String#>, <#args: CVarArgType#>...)
////        //request.predicate = NSPredicate(format: "username = %@", "Susan"); //%@ is placeholede r for string we want to search for
////        
////        
////        
////        // get array of results
////        
//        var results = context.executeFetchRequest(request, error: nil);
//        println("Results from DB \(results)");
//
        
        //loop through results array and fist check result not null
       
        
//        if results?.count > 0{
//            
//            println("\n\nTotal DB Numbers: \(results?.count)");
//            
//            
//            for result : AnyObject in results! {
//                
//                //var casenum : String = result.valueForKey?("caseNumber") as String;
//                
//                
//                //println("\n\nPrinting The DataBSE Result: \(result)\n\nPrinting the result case number \(casenum)");
//                
//                if(result.valueForKey("caseNumber") == nil){
//                    
//                    println("Deletong object of nil from DB");
//                    
//                    context.deleteObject(result as NSManagedObject);
//                    
//                    
//                    // save changes
//                    context.save(nil);
//                    
//                }
        
                //context.delete(result);
                
                // Handle result : anyobject optional type by using a if - let staement
//                if let username = result.valueForKey("username") as? String {
//                    
//                    println(username);
//                    
//                    // delete a result
//                    if (username == "Susan"){
//                        
//                        // DELETE AN ENTRY
//                        //context.deleteObject(result as NSManagedObject); // forse downcast result : anyobject to NSMAnagedObject
//                        //println(username + " has been deleted");
//                        
//                        
//                        //UPDATE A ENTRY IE PASSWORD
//                        result.setValue("betterPassword", forKey: "password");
//                        var newP = result.valueForKey("password") as String;
//                        
//                        println(username + " password changed to " + newP);
//                        
//                        
//                    }
//                    
//                    
//                }
                
                
                
                // Search database for result
                
//                
//                
//            }
//        } else{
//            
//            println("No Data, no of entries = \(results?.count)");
//        }
        

            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    
    
    @IBAction func unwindToLogINViewController (sender: UIStoryboardSegue) {
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to, only do if os =>8.0
        
        if(iOSVersion.SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("8.0")){
            
  
        
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        
        toViewController.transitioningDelegate = self.transitionManager
            
        }
    }
    
    func startLoader(yesorno : Bool){
        
        if(yesorno){
            
            //animate and disable user interaction
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge;
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
        }else if(!yesorno){
            
            // tun off lodare and enable user interaction with view
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents();
            
        }

    }
}// class
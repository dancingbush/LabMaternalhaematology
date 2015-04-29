//
//  MainMenuViewController.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 09/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//
// DEBUGGING: New Device must clear core data base and enter new URLS for images on that device so, STE saveToDB TO FALSE WHEN RNNING ON A NEW DEVICE AS NEED THE TO DSAVE THE IMAGE DATA TO DOCS DIR - AND DELTE OBJECTS TO TRUE, THEW QUIT APP AND SET saveToDB = TRUE, delteObj = FALSE, THIS WILLS ET EVRTYHTING UP, QUIT AND NOW SET BOTH TO FALSE RUN AGAIN


import UIKit
import MessageUI
import CoreData


// Globals Functions so we can access in inscance varibles

var datdaBaseHasBeenCheckedOnceDuringThisAppLaunch : Bool = false;

var totalCases = ""; //used in CasesTavbleview Line 448

func documentsDirectory() -> String {
    
    // Get the documents Directory for image url
    
    
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String;
    return documentsFolderPath
    
    
    
    
}


func fileInDocumentsDirectory(filename: String) -> String {
    
    // Get path for a file in the directory
    
    return documentsDirectory().stringByAppendingPathComponent(filename);
    
    
}



class MainMenuViewController: UIViewController, MFMailComposeViewControllerDelegate {

    /*Manage ransistions*/
    let transitionManager = TransistionManager();
    
    // Define the specific path, image name
    let imagePath = fileInDocumentsDirectory("");
    
    var imageNameToSaveURL = "";
    
    //array to hold umage name from databse
    var arrayOfIUmages : [String] = [];
    
    var ArrayOfParseImages : [UIImage] = [];
    
    var arrayOfCoredataImage : [String] = []; //holds urls ro image
    
    var arrayOfParseCaseNumbers : [String] = [];
    
    var arrayOfCoreDataCaseNumbers : [String] = [];
    
    var arrayParseCases : [String] = [];
    
    var noOfImagesDownloaded = 1; //track the asyn downloading of images
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    
    
    
    
    
    
    // Views
    
    @IBOutlet weak var labelWelcomeUser: UILabel!
    
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    //@IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var buttonCases: UIButton!
    
    
    @IBAction func buttonCases(sender: AnyObject) {
        
        self.performSegueWithIdentifier("segueToCaseTableView", sender: self);
        
        
    }
    
    
    @IBAction func buttonLogOut(sender: AnyObject) {
        
        
        PFUser.logOut();
        
        
        self.performSegueWithIdentifier("segueToLogInScreen", sender: self);
        
    }
    
    @IBAction func buttonAbout(sender: AnyObject) {
        
        self.performSegueWithIdentifier("segueToAbout", sender: self);
        
        
    }
    
    
    @IBAction func buttonInivite(sender: AnyObject) {
        
        
        
        if (MFMailComposeViewController.canSendMail()) {
            
            var emailTitle = "Lab Case Studies: Maternal-Newborn Haematology"
            var messageBody = "Hey, check out this app I have been using for case studies in Laboratory Haematology in a maternal -newborn setting. Cases include 3 questions and micrscopy to interpret, great for CPD! "
            //var toRecipents = ["pj@veasoftware.com"]
            
            var mc:MFMailComposeViewController = MFMailComposeViewController()
            
            mc.mailComposeDelegate = self
           
            mc.setSubject(emailTitle)
            
            mc.setMessageBody(messageBody, isHTML: false)
            
            //mc.setToRecipients(toRecipents)
            
            self.presentViewController(mc, animated: true, completion: nil)
            
        }else {
            
            println("No email account found")
            
        }

    }
    
    
    override func viewWillAppear(animated: Bool) {
        // gets called evrytime the view is loaded
        
        println("VIEWWILLAPEEAR: MAIN MENU");
        
        //loader.hidden = true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("VIEW DID LOAD: MAIN MENU");
        
        /* viewDidLoad gets called only once the view is contructed, and not when call the view firm a stack. THe view will not appear UNTIL the viewDidlOad has finsihed....viewWillAppear gets called every time the view appears. You should do things that you only have to do once in viewDidLoad*/

        // set up emailclient and label welcome
        
        if(isARegsiteredUser){
            
        
        labelWelcomeUser.text = "Welcome Back \(currentUserName)!";
            
    } else {
    
    labelWelcomeUser.text = "Welcome \(currentUserName)!";
    
    
    }
        
        /* Tested:
        - Core Data Empty = ok
        - Pasre Data Empty = ok
        - Core data and Parse data have same highest number case = ok
        - core data has less cases than Parse and downloads the enxt case = ok
        - Parse has two more cases higher than the last Core data Case = ok

        */
        // create the loader, called in sepreate func
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true

        
        
        
        
        
    }// view did load
    
    
    func checkParseForNewCase(){
        
        /*Do here and not in voew did load so GUI is not latent
          add a case to test corde dtabase here*/
        
        // writeToPracticeCoreData();
        
        // Debugging see if new case added correctly
        //checkCoreDataForNewCase();
        
        //deleteALlObjectsFromCoredAta();
        
        // check for new arse case, if this has been done once during this app launch and we have moved bacvk to main menbu then dont do again
        
        if(Reachability.isConnectedToNetwork() == true){
            
            println("Internet connection estabished");
            
            //checkParseForNewCase();
            
       
        if(!datdaBaseHasBeenCheckedOnceDuringThisAppLaunch){
            
//            // create the loader, called in sepreate func
//            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
//            activityIndicator.center = self.view.center
//            activityIndicator.hidesWhenStopped = true
            
            
            arrayOfCoreDataCaseNumbers = getCaseNumbersFromCoreData();
            
            arrayOfParseCaseNumbers = downloadCaseNumbersFromParse(); // check for new case made here
            
            
        }
        datdaBaseHasBeenCheckedOnceDuringThisAppLaunch=true;
        
        }else if (Reachability.isConnectedToNetwork() == false) {
            
            println("No wifi or 3g detecetd");
            
            displayAlert("Wi-Fi/3G", message: "No internet connection detected...cannot check for new cases right now....")
            
        }

    }
    
    
    
    func downloadCaseNumbersFromParse() -> Array<String>{
        
        // query parse case stidies class and get the case number query
        
        startLoader(true);
        
        var loadParseToCore = false;
        
        //arrayParseCases : [String] = [""];
        
       // var newCase = PFQuery(className:"TestCase");
        var newCase = PFQuery(className:"NewCase");
        
        newCase.findObjectsInBackgroundWithBlock { (objects : [AnyObject]!, error: NSError!) -> Void in
            
            println("\n\nTHREAD - CASE FROM PARSE START\n\n");
            
            if error == nil{
                
                for theCase in objects{
                    
                    println("Case succesfully from Parse: \(theCase)");
                    
                    
                    let caseNumber = theCase["caseNumber"] as String;
                    
                    self.arrayParseCases.append(caseNumber);
                    
                    
                }//for
                
                self.startLoader(false);
                
            }//if nil
            else{
                
                println("\nCant download case from parse error = : \(error)");
                
                self.startLoader(false);
            }
            
            
            
            // Sort our array of strings represtning each case number with a sort closure
            self.arrayParseCases = sorted(self.arrayParseCases, {
                (str1: String , str2 : String) -> Bool in
                
                return str1.toInt() < str2.toInt();
            })
            
            println("\n\nSorted Addray Of Pasre Cases in order of ccase no: \(self.arrayParseCases)");
            
            
            
            /*Do this here instead of viewDidLoad as tasks run aysnchorouny*/
            
            if(!self.arrayParseCases.isEmpty){
                
                
                
                var lastCaseNuberFromParse : Int = self.arrayParseCases.last!.toInt()!;
            
            
            
            if var lastCaseNuberFromCore : Int = self.arrayOfCoreDataCaseNumbers.last!.toInt(){
                
                println("Last case i core data = \(lastCaseNuberFromCore) Last case in Parse = \(lastCaseNuberFromParse)");
                
                if(lastCaseNuberFromParse > lastCaseNuberFromCore){
                    
                    // write case from parse to core data after gd task executes
                    
                    self.loadCaseFromParseTo_CoreData();
                    
                    //loadParseToCore = true;
                    
                    
                }else{
                    
                    println("NOT ADDING A CASE TO CORE DATA FROM PARSE AS BOTH DB'S ARE SYNCHED..core last case = \(lastCaseNuberFromCore) and Parse DB last case : \(lastCaseNuberFromParse)");
                    
                    self.startLoader(false);
                }

                
            
            }// if let
            else{
                
                println("Core Data Base empty, cant add  aparse case unless CD base has at least one entry with a cse number\n");
                
               self.startLoader(false);
            }
            
            
            }// if let arayParse last int
            else{
                
                println("PAsre Data Base empty, cant add  aparse case unless CD base has at least one entry with a cse number\n");
                
                    self.startLoader(false);
            }
            
            println("\n\nTHREAD - CASE FROM PARSE FINISH \n\n");
            
//            if(loadParseToCore){
//                
//                self.loadCaseFromParseTo_CoreData();
//                
//            }
        }// bgrd task
        
        
       // self.startLoader(false);
        
        return arrayParseCases;
        
        
    }// donloadFromParse
    
    
    
    
    
    
    func getCaseNumbersFromCoreData() -> Array<String>{
        
        // query core data stidies class and get the case number query
        var arrayCoreCases : [String] = [""];
        
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        //var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("TestParse", inManagedObjectContext: context) as NSManagedObject;
        
        var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("Case", inManagedObjectContext: context) as NSManagedObject;
        
        var error : NSError? = nil;
        
        
        var request = NSFetchRequest(entityName: "Case");
        
        // for beta 4 xcode only
        request.returnsObjectsAsFaults = false;
        
        var results  = context.executeFetchRequest(request, error: nil);
        
        println("\n\nResults from DB \(results?.count) and teh results object \(results)\n\n");
        
        if results?.count > 1{
            
            
            
            
            for result : AnyObject in results! {
                
                
                println("Database object form parse: \(result.count) and contents : \(result.description)");
                
                
                
                    
                    //context.deleteObject(result as NSManagedObject);
                    
                    
                    
                    
                    //context.save(&error);
                    
                    //println("DELETED CORE DATA OBJECT : \(result)");
             
                    
                    
                    // Save to arrays only of a value exists ie not == nil
                    if let tehCaseNumber : String = result.valueForKey("caseNumber") as? String{
                        
                        arrayCoreCases.append(result.valueForKey("caseNumber") as String);
                        
                        
                        
                        println("\n\nCOre data Case Numbers Array number = \(arrayCoreCases.count) and contents \(arrayCoreCases)\n\n");
                        
                    } else {
                        
                        println("No Data, no of entries = \(results?.count)");
                        
//                        self.loader.stopAnimating();
//                        self.loader.hidden = true;
                        
                        
                    } // else
                    
                }//!deleteFRomDA
                
            } // for


        
        
        
        // Sort the array strings numbers into soted array of incraesing string integers
        
        arrayCoreCases = sorted(arrayCoreCases, {(
            str1: String, str2: String) -> Bool in
            
            return str1.toInt() < str2.toInt();
            
        })
       
        
        // assign the total cases for use in CaseTableView\
        totalCases = arrayCoreCases.last! as String;
        
        println("\n\nSorted Addray Of Core Data Cases in order of ccase no: \(arrayCoreCases)");
        return arrayCoreCases;
    }
    
    
    

    
    func loadCaseFromParseTo_CoreData(){
        
        // query Parse Object and load to core data
        
       
        self.startLoader(true);
        
        println("Animating and Loading case from parse.....array Parse \(arrayParseCases.count)");
        
        for caseNoInParseArray in arrayParseCases{
            
            var caseInteger = caseNoInParseArray.toInt();
            
            var lastCaseInCoreData = self.arrayOfCoreDataCaseNumbers.last?.toInt();
            
            println("\n\nChecking if case in Parse is greater than last case in Core, if so then download to core data..current case of array in parse = \(caseInteger) Last case in core \(lastCaseInCoreData)\n\n");
            
            
            if(caseInteger > lastCaseInCoreData){
                
                /* write case from parse tro core data
                
                
                get context objxt and create a user entry with it*/
                
                
                 //startLoader(true);
                
                
                var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
                
                var context : NSManagedObjectContext = appDel.managedObjectContext!;
                
                var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("Case", inManagedObjectContext: context) as NSManagedObject;
                
                var error : NSError? = nil;
                
                
                // Get pasre case
                
                //var newCase = PFQuery(className:"TestCase");
                var newCase = PFQuery(className:"NewCase");

                
                newCase.whereKey("caseNumber", equalTo: caseNoInParseArray)
                
                newCase.findObjectsInBackgroundWithBlock { (objects : [AnyObject]!, error: NSError!) -> Void in
                    
                    println("\n\nTHREAD - CASE FROM PARSE TO CORE DATA START, NO OF CASES = \(objects.count)\n\n");
                    if error == nil{
                        
                        for theCase in objects{
                            
                            println("Case succesfully from Parse: \(theCase)");
                            
//                            let imageName = theCase["image1"] as String;
//                            let history = theCase["History"] as String;
//                            let q1 = theCase["Question1"] as String;
//                            let q2 = theCase["Question2"] as String;
//                            let isCaseFromParse = theCase["IsParseCase"] as Bool;
//                            
//                            let caseNumber = theCase["CaseNumber"] as String;
                            // n = 45 attributes
                            
                            let age  = theCase["age"] as String;
                             let apgar  = theCase["apgar"] as String;
                             let caseNumber  = theCase["caseNumber"] as String;
                             let caseSummary  = theCase["caseSummary"] as String;
                             let hgb  = theCase["hgb"] as String;
                             let history  = theCase["history"] as String;
                             let mch  = theCase["mch"] as String;
                             let mchc  = theCase["mchc"] as String;
                             let mcv  = theCase["mcv"] as String;
                             let others  = theCase["others"] as String;
                             let parsecase  = theCase["parsecase"] as Bool;
                             let plts  = theCase["plts"] as String;
                            
                             let q1Answer  = theCase["q1Answer"] as String;
                            
                             let q1ImageTitleA  = theCase["q1ImageTitleA"] as String;
                            let q1ImageTitleB  = theCase["q1ImageTitleB"] as String;
                            let q1ImageTitleC  = theCase["q1ImageTitleC"] as String;
                            let q1ImageTitleD  = theCase["q1ImageTitleD"] as String;
                            
                            let q2OptionA  = theCase["q2OptionA"] as String;
                            let q2OptionADialog  = theCase["q2OptionADialog"] as String;
                            let q2OptionB  = theCase["q2OptionB"] as String;
                            let q2OptionBDialog  = theCase["q2OptionBDialog"] as String;
                            let q2OptionC  = theCase["q2OptionC"] as String;
                            let q2OptionCDialog  = theCase["q2OptionCDialog"] as String;
                            let q2OptionD  = theCase["q2OptionD"] as String;
                            let q2OptionDDialog  = theCase["q2OptionDDialog"] as String;
                            
                            /*Images are Files in Parse so handle differently below*/
                            
//                            let question1Image1  = theCase["question1Image1"] as String;
//                            let question1Image2  = theCase["question1Image2"] as String;
//                            let question1Image3  = theCase["question1Image3"] as String;
//                            let question1Image4  = theCase["question1Image4"] as String;
                            
                            let question2Answer  = theCase["question2Answer"] as String;
                            let question3Answer  = theCase["question3Answer"] as String;
                            let question3OptionA  = theCase["question3OptionA"] as String;
                            let question3OptionB  = theCase["question3OptionB"] as String;
                        
                            let question3OptionC  = theCase["question3OptionC"] as String;
                            let question3OptionD  = theCase["question3OptionD"] as String;
                            
                            let question_image1OptionA  = theCase["question_image1OptionA"] as String;
                            let question_image1OptionB  = theCase["question_image1OptionB"] as String;
                            let question_image1OptionC  = theCase["question_image1OptionC"] as String;
                            let question_image1OptionD  = theCase["question_image1OptionD"] as String;
                            
                            let sex  = theCase["sex"] as String;
                            let summary  = theCase["summary"] as String;
                            
                            let temperature  = theCase["temperature"] as String;
                            let theQuestion2  = theCase["theQuestion2"] as String;
                            let theQuestion3  = theCase["theQuestion3"] as String;
                            let wcc  = theCase["wcc"] as String;
                            
                            
                            
                            //if(saveToDataBase){
                                
                                // Save from parse to core data Entty TestParse
                                newEntry3.setValue(age, forKey: "age");
                                newEntry3.setValue(apgar, forKey: "apgar");
                                newEntry3.setValue(caseNumber, forKey: "caseNumber");
                                newEntry3.setValue(caseSummary , forKey: "caseSummary");
                            newEntry3.setValue(hgb, forKey: "hgb");
                            
                            newEntry3.setValue(history, forKey: "history");
                            newEntry3.setValue(mch, forKey: "mch");
                            newEntry3.setValue(mchc, forKey: "mchc");
                            newEntry3.setValue(mcv, forKey: "mcv");
                            newEntry3.setValue(others, forKey: "others");
                            
                            newEntry3.setValue(plts, forKey: "plts");
                             newEntry3.setValue(parsecase, forKey: "parsecase");
                            newEntry3.setValue(q1Answer, forKey: "q1Answer");
                            newEntry3.setValue(q1ImageTitleA, forKey: "q1ImageTitleA");
                            newEntry3.setValue(q1ImageTitleB, forKey: "q1ImageTitleB");
                            
                            newEntry3.setValue(q1ImageTitleC, forKey: "q1ImageTitleC"); newEntry3.setValue(q1ImageTitleD, forKey: "q1ImageTitleD");
                            newEntry3.setValue(q2OptionA, forKey: "q2OptionA");
                            newEntry3.setValue(q2OptionADialog, forKey: "q2OptionADialog");
                            newEntry3.setValue(q2OptionB, forKey: "q2OptionB");
                            newEntry3.setValue(q2OptionBDialog, forKey: "q2OptionBDialog");
                            
                            newEntry3.setValue(q2OptionC, forKey: "q2OptionC");
                            newEntry3.setValue(q2OptionCDialog, forKey: "q2OptionCDialog");
                            newEntry3.setValue(q2OptionD, forKey: "q2OptionD");
                            newEntry3.setValue(q2OptionDDialog, forKey: "q2OptionDDialog");
                           
                            /*Images are Files in Parse so handle differently below*/

//                            newEntry3.setValue(question1Image1, forKey: "question1Image1");
//                            
//                            newEntry3.setValue(question1Image2, forKey: "question1Image2");
//                            newEntry3.setValue(question1Image3, forKey: "question1Image3");
//                            newEntry3.setValue(question1Image4, forKey: "question1Image4");
                            
                            newEntry3.setValue(question2Answer, forKey: "question2Answer");
                            newEntry3.setValue(question3Answer, forKey: "question3Answer");
                            
                            newEntry3.setValue(question3OptionA, forKey: "question3OptionA");
                            newEntry3.setValue(question3OptionB, forKey: "question3OptionB");
                            newEntry3.setValue(question3OptionC, forKey: "question3OptionC");
                            newEntry3.setValue(question3OptionD, forKey: "question3OptionD");
                            
                            
                            newEntry3.setValue(question_image1OptionA, forKey: "question_image1OptionA");
                            newEntry3.setValue(question_image1OptionB, forKey: "question_image1OptionB");
                            newEntry3.setValue(question_image1OptionC, forKey: "question_image1OptionC");
                            newEntry3.setValue(question_image1OptionD, forKey: "question_image1OptionD");
                            newEntry3.setValue(sex, forKey: "sex");
                            
                            newEntry3.setValue(summary, forKey: "summary");
                            newEntry3.setValue(temperature, forKey: "temperature");
                            newEntry3.setValue(theQuestion2, forKey: "theQuestion2");
                            newEntry3.setValue(theQuestion3, forKey: "theQuestion3");
                            newEntry3.setValue(wcc, forKey: "wcc");
                            
                                println("\n\nCOMMIT STRIGS TO DATABASE\n\n");
                            
                            var error : NSError? = nil;
                            
                            context.save(&error);
                                
                          
                            
                            
                            /*Download image fils from parse and convert to UIIMage, save it o phone directpry then save image title only (not dirctory plus title) to the core data base, when we load back we load with image name from core data plus durectiory using the dirctory fucntions*/
                            
                            var fileExtenion = "";
                            
                            let caseImageFile1 = theCase["question1Image1"] as PFFile
                            caseImageFile1.getDataInBackgroundWithBlock {
                                (imageData: NSData!, error: NSError!) -> Void in
                                
                                println("\n\nTHREAD - IMAGE1 FROM PARSE TO CORE START\n\n");
                                
                                if error == nil {
                                    
                                    let image = UIImage(data:imageData)
                                    
                                    
                                    // Get url of image from data from parse so we can check if t os a png or jpeg extensiom
                                    
                                    let imageURLFromParse = caseImageFile1.url;
                                    
                                 
                                    
                                    if(imageURLFromParse.pathExtension.lowercaseString == ".jpg" || imageURLFromParse.pathExtension.lowercaseString == ".jpeg"){
                                        
                                        println("Parse image ext is a jpg: \(imageURLFromParse.pathExtension.lowercaseString)");
                                        
                                        fileExtenion = ".jpg";
                                        
                                    }else if (imageURLFromParse.pathExtension.lowercaseString == ".png"){
                                        
                                        println("Parse image is a png: \(imageURLFromParse.pathExtension.lowercaseString)");
                                        
                                        fileExtenion = ".png";
                                        
                                    }
                                        
                                    else{
                                        fileExtenion = ".png";
                                        
                                        println("DEFAULTING TO file tyoe, Parse image is a png: \(imageURLFromParse.pathExtension.lowercaseString)");
                                    }
                                    
                                    
                                    // Imahe url/name
                                    var imgaeURLName = "Case\(caseNoInParseArray)a\(fileExtenion)";
                                    
                                    
                                    // Save as URL ro phone and then to core data as URL string
                                    
                                    
                                    var filePath = fileInDocumentsDirectory(imgaeURLName);
                                    
                                    println("\n\nSAVING image to directory : \(filePath)");
                                    
                                    self.saveImageToDirectory(image!, path: filePath, imageType: fileExtenion);
                                    
                                    
                                    
                                    
                                    // save to core data object : Only Save the image name and not full path as will not reload properly after quiting and starting app!! When we reload image we just get the path from functions and appedn the imagename form core data
                                    
                                    var error : NSError? = nil;
                                    
                                    newEntry3.setValue(imgaeURLName, forKey: "question1Image1");
                                    
                                    context.save(&error);
                                    
                                    
                                    
                                    
                                    /*Make sure image is retrivable form directory of phone*/
                                    var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                                    
                                    println("\n\nThe image retruend from URL : \(coredDataImage.description)");
                                    
                                    
                                    println("\n\nTHREAD - FINISHED SAVING IMAGE1 FROM PARSE TO CORE, NO OF IMAGES DOWNLOADED = \(self.noOfImagesDownloaded)\n");
                                    
                                    
                                    //if all images downloaded then stop animation
                                    
                                    self.noOfImagesDownloaded++;
                                    
                                    if(self.noOfImagesDownloaded == 5){
                                        
//                                        self.loader.stopAnimating();
//                                        self.loader.hidden = true;
                                        
                                        //reset
                                        self.noOfImagesDownloaded = 1;
                                        
                                        self.startLoader(false);


                                        
                                        
                                    }
                                    
                                
                                }
                            }// caseimage
                            
                            let caseImageFile2 = theCase["question1Image2"] as PFFile
                            
                            caseImageFile2.getDataInBackgroundWithBlock {
                                (imageData: NSData!, error: NSError!) -> Void in
                                
                                if error == nil {
                                    
                                    println("\n\nTHREAD - STARTED SAVING IMAGE42 FROM PARSE TO CORE\n");
                                    
                                    let image = UIImage(data:imageData)
                                    self.ArrayOfParseImages.append(image!);
                                    
                                    println("Images Array from Parse Count: \(self.ArrayOfParseImages.count) ")
                                    
                                   
                                    let imageURLFromParse = caseImageFile2.url;
                                    
                                    if(imageURLFromParse.pathExtension.lowercaseString == ".jpg" || imageURLFromParse.pathExtension.lowercaseString == ".jpeg"){
                                        
                                        println("Parse image ext is a jpg: \(imageURLFromParse.pathExtension.lowercaseString)");
                                        
                                        fileExtenion = ".jpg";
                                        
                                    }else {
                                        
                                        println("Parse image is a png: \(imageURLFromParse.pathExtension.lowercaseString)");
                                        
                                        fileExtenion = ".png";
                                        
                                    }
                                    
                                    
                                    // Imahe url/name
                                    var imgaeURLName = "Case\(caseNumber)b\(fileExtenion)";
                                    
                                    
                                    // Save as URL ro phone and then to core data as URL string
                                    
                                    
                                    var filePath = fileInDocumentsDirectory(imgaeURLName);
                                    
                                    println("\n\nSAVING image to directory : \(filePath)");
                                    
                                    self.saveImageToDirectory(image!, path: filePath, imageType: fileExtenion);
                                    
                                    var error : NSError? = nil;
                                    
                                    newEntry3.setValue(imgaeURLName, forKey: "question1Image2");
                                    
                                    context.save(&error);
                                    
                                    var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                                    
                                    println("\n\nThe image retruend from URL : \(coredDataImage.description)");
                                    
                                    println("\n\nTHREAD - FINISHED SAVING IMAGE2 FROM PARSE TO CORE, NO OF IMAGES DOWNLOADED = \(self.noOfImagesDownloaded)\n");
                                    
                                    
                                    //if all images downloaded then stop animation
                                    
                                    self.noOfImagesDownloaded++;
                                    
                                    if(self.noOfImagesDownloaded == 5){
                                        
//                                        self.loader.stopAnimating();
//                                        self.loader.hidden = true;
                                        
                                        //reset
                                        self.noOfImagesDownloaded = 1;
                                        
                                        self.startLoader(false);
                                        
                                    }

                           
                                    
                                    
                                }
                            }// caseimage
                            
                            let caseImageFile3 = theCase["question1Image3"] as PFFile
                            caseImageFile3.getDataInBackgroundWithBlock {
                                (imageData: NSData!, error: NSError!) -> Void in
                                
                                println("\n\nTHREAD - STARTED SAVING IMAGE3 FROM PARSE TO CORE\n");
                                
                                if error == nil {
                                    
                                    let image = UIImage(data:imageData)
                                    self.ArrayOfParseImages.append(image!);
                                    
                                    println("Images Array from Parse Count: \(self.ArrayOfParseImages.count) ")
                                    
                                   
                                    
                                    
                                    let imageURLFromParse = caseImageFile3.url;
                                    
                                    if(imageURLFromParse.pathExtension.lowercaseString == ".jpg" || imageURLFromParse.pathExtension.lowercaseString == ".jpeg"){
                                        
                                        println("Parse image ext is a jpg: \(imageURLFromParse.pathExtension.lowercaseString)");
                                        
                                        fileExtenion = ".jpg";
                                        
                                    }else {
                                        
                                        println("Parse image is a png: \(imageURLFromParse.pathExtension.lowercaseString)");
                                        
                                        fileExtenion = ".png";
                                        
                                    }
                                    
                                    
                                    // Imahe url/name
                                    var imgaeURLName = "Case\(caseNumber)c\(fileExtenion)";
                                    
                                    
                                    // Save as URL ro phone and then to core data as URL string
                                    
                                    
                                    var filePath = fileInDocumentsDirectory(imgaeURLName);
                                    
                                    println("\n\nSAVING image to directory : \(filePath)");
                                    
                                    self.saveImageToDirectory(image!, path: filePath, imageType: fileExtenion);
                                    
                                    
                                    
                                    
                                    // save to core data object : Only Save the image name and not full path as will not reload properly after quiting and starting app!! When we reload image we just get the path from functions and appedn the imagename form core data
                                    
                                    var error : NSError? = nil;
                                    
                                    newEntry3.setValue(imgaeURLName, forKey: "question1Image3");
                                    
                                    context.save(&error);
                                    
                                    var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                                    
                                    println("\n\nThe image retruend from URL : \(coredDataImage.description)");
                                    
                                    println("\n\nTHREAD - FINISHED SAVING IMAGE3 FROM PARSE TO CORE, NO OF IMAGES DOWNLOADED = \(self.noOfImagesDownloaded)\n");
                                    
                                    
                                    //if all images downloaded then stop animation
                                    
                                    self.noOfImagesDownloaded++;
                                    
                                    if(self.noOfImagesDownloaded == 5){
                                        
//                                        self.loader.stopAnimating();
//                                        self.loader.hidden = true;
                                        
                                        
                                        // reset
                                        self.noOfImagesDownloaded = 1;
                                        
                                        
                                        self.startLoader(false);
                                    }

                                    
                                    
                                    
                                }
                            }// caseimage
                            
                            let caseImageFile4 = theCase["question1Image4"] as PFFile
                            caseImageFile4.getDataInBackgroundWithBlock {
                                
                                
                                
                                (imageData: NSData!, error: NSError!) -> Void in
                                
                                 println("\n\nTHREAD - STARTED SAVING IMAGE4 FROM PARSE TO CORE\n");
                                
                                if error == nil {
                                    
                                    let image = UIImage(data:imageData)
                                    self.ArrayOfParseImages.append(image!);
                                    
                                    println("Images Array from Parse Count: \(self.ArrayOfParseImages.count) ")
                                    
                                
                                    
                                    
                                    let imageURLFromParse = caseImageFile4.url;
                                    
                                    if(imageURLFromParse.pathExtension.lowercaseString == ".jpg" || imageURLFromParse.pathExtension.lowercaseString == ".jpeg"){
                                        
                                        println("Parse image ext is a jpg: \(imageURLFromParse.pathExtension.lowercaseString)");
                                        
                                        fileExtenion = ".jpg";
                                        
                                    }else {
                                        
                                        println("Parse image is a png: \(imageURLFromParse.pathExtension.lowercaseString)");
                                        
                                        fileExtenion = ".png";
                                        
                                    }
                                    
                                    
                                    // Imahe url/name
                                    var imgaeURLName = "Case\(caseNumber)d\(fileExtenion)";
                                    
                                    
                                    // Save as URL ro phone and then to core data as URL string
                                    
                                    
                                    var filePath = fileInDocumentsDirectory(imgaeURLName);
                                    
                                    println("\n\nSAVING image to directory : \(filePath)");
                                    
                                    self.saveImageToDirectory(image!, path: filePath, imageType: fileExtenion);
                                    
                                    
                                    
                                    
                                    // save to core data object : Only Save the image name and not full path as will not reload properly after quiting and starting app!! When we reload image we just get the path from functions and appedn the imagename form core data
                                    
                                    var error : NSError? = nil;
                                    
                                    newEntry3.setValue(imgaeURLName, forKey: "question1Image4");
                                    
                                    context.save(&error);
                                    
                                    var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                                    
                                    println("\n\nThe image retruend from URL : \(coredDataImage.description)");
                                    
                                    println("\n\nTHREAD - FINISHED SAVING IMAGE4 FROM PARSE TO CORE, NO OF IMAGES DOWNLOADED = \(self.noOfImagesDownloaded)\n");
                                    
                                    
                                    //if all images downloaded then stop animation
                                    
                                    self.noOfImagesDownloaded++;
                                    
                                    if(self.noOfImagesDownloaded == 5){
                                        
//                                        self.loader.stopAnimating();
//                                        self.loader.hidden = true;
                                        
                                        
                                        // reset
                                        self.noOfImagesDownloaded = 1;
                                        
                                        self.startLoader(false);
                                        
                                    }
                                    

                                }
                            
                            }
                            
                                    
                                    
                        } //for case in objects
                        
                        
                        
                        
                        
                        
                        
                    } else {
                        
                        println("Error retriving data form Parse : \(error)");
                        
                        self.displayAlert("Opps", message: "Soemthing went worig retriving new case study, please try later : \(error)");
                        

                        self.startLoader(false);
                    }
                
                    println("\n\nTHREAD - CASE FROM PARSE TO CORE DATA FINISH - NOW CHECK CORED DATA FUNC CALL\n\n");
                    
                    self.checkCoreDataForNewCase();
                
            }// if
            
            
            
            
            
            
            /* update array of core data cases so include any new ones we have addaed from parse*/
            
            self.arrayOfCoreDataCaseNumbers = getCaseNumbersFromCoreData();
            
            
        }// for arraOfParse
        
        
      
    }// Load from parse
    
    }
    
        
        func saveImageToDirectory(image : UIImage, path: String, imageType: String) -> Bool{
            
            /* Save image to directory in phone return bool if sussecful*/
            
            if(imageType.rangeOfString("png") != nil) {
                
                let pngImageData = UIImagePNGRepresentation(image);
                
                let result = pngImageData.writeToFile(path, atomically: true);
                
                
                //pngFullData.writeToFile(pathFull, atomically: true)
                
                return result;
                
            } else{
                
                let jpgImageData = UIImageJPEGRepresentation(image, 1.0);
                
                let result = jpgImageData.writeToFile(path, atomically: true);
                
                return result;
                
            }
            
            
            
            
            
        }

    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result.value {
            
        case MFMailComposeResultCancelled.value:
            println("Mail Cancelled")
            
            displayAlert("Email Error", message: "Possible internet connection issue, please try later..");
            
        case MFMailComposeResultSaved.value:
            println("Mail Saved")
            
        case MFMailComposeResultSent.value:
            println("Mail Sent")
            
            displayAlert("Email", message: "SENT!");
        case MFMailComposeResultFailed.value:
            println("Mail Failed")
            
            displayAlert("Email Error", message: "Possible internet connection issue, please try later..");
        default:
            break
            
        }
        self.dismissViewControllerAnimated(false, completion: nil)
        
        
    }
    //}

    
    
    
    
    func displayAlert(title : String, message : String){
        
        //self.loader.stopAnimating();
        
        var alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    
    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    
    
    
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue) {
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkCoreDataForNewCase() {
        
        /*Query core data fro addition of any cases, for debugging*/
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("Case", inManagedObjectContext: context) as NSManagedObject;
        
        var error : NSError? = nil;
        
        
        var request = NSFetchRequest(entityName: "Case");
        
        // for beta 4 xcode only
        request.returnsObjectsAsFaults = false;
        
        var results  = context.executeFetchRequest(request, error: nil);
        
        println("\n\nChecking if new case added to database: Results from DB \(results?.count) and teh results object \(results)\n\n");
        
        if results?.count > 1{
            
            
            
            
            for result : AnyObject in results! {
                
                
                println("Database object form parse: \(result.count) and contents : \(result.description)");
                
                
                
                
                //context.deleteObject(result as NSManagedObject);
                
                
                
                
                //context.save(&error);
                
                //println("DELETED CORE DATA OBJECT : \(result)");
            }//for
            
                } else {
                    
                    println("No Data, no of entries = \(results?.count)");
                    
                    
                } // else
                
        
            
        } // method

        
    
    func loadImageFromPath(path : String) -> UIImage{
    
        
        // GET IMAGE FROM CORE DATA DEBUGGING ONLY
        
        let image = UIImage(contentsOfFile: path); // returns an image from specofoed file (string)
        
        
        println("\n\nImage returned from File : \(image?.description)\n\n");
        
        
        if image == nil{
            
            println("No image loading form path : \(path)");
            
        }
        
        println("\n\nImage is stored in this location - can find in Finder: \(path)");
        
        return image!;
        
    }


    func writeToPracticeCoreData(){
        
        /* Write to core data base for debugging only */
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("TestParse", inManagedObjectContext: context) as NSManagedObject;
        
        var error : NSError? = nil;
        
        // Save from parse to core data Entty TestParse
        newEntry3.setValue("Test Non Parse History case 4", forKey: "history");
        newEntry3.setValue("Test Question 1", forKey: "q1");
        newEntry3.setValue("Test Question 1", forKey: "q2");
        newEntry3.setValue("4" , forKey: "casenumber");
        newEntry3.setValue(false, forKey: "is_a_parsecase");
        
        println("\n\nADDING CASE  TO PRACTICE DARABASE \n\n");
        
        
        context.save(&error);

        
    }
   
    
    
   func  deleteALlObjectsFromCoredAta(){
    
    //debugging
    
    println("\nDeleting all objects form core data.....\n");
    
    var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
    
    var context : NSManagedObjectContext = appDel.managedObjectContext!;
    
    var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("TestParse", inManagedObjectContext: context) as NSManagedObject;
    
    var error : NSError? = nil;
    
    
    var request = NSFetchRequest(entityName: "TestParse");
    
    // for beta 4 xcode only
    request.returnsObjectsAsFaults = false;
    
    var results  = context.executeFetchRequest(request, error: nil);
    
    println("\n\nChecking if new case added to database: Results from DB \(results?.count) and teh results object \(results)\n\n");
    
    if results?.count > 1{
        
        
        
        
        for result : AnyObject in results! {
            
            
            println("Database object form parse: \(result.count) and contents : \(result.description)");
            
            
            
            
            context.deleteObject(result as NSManagedObject);
            
            
            
            
            context.save(&error);
            
            println("DELETED CORE DATA OBJECT : \(result)");
        }//for
        
    } else {
        
        println("No Data or reached end of data , no of entries = \(results?.count)");
        
        
    } // else

     println("\nall objects deleted form core data.....DB count = \(results?.count)");
    
    }
    
    
    
    
    func startLoader(yesorno : Bool){
        
        if(yesorno){
            
            //animate and disable user interaction
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray;
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
        }else if(!yesorno){
            
            // tun off lodare and enable user interaction with view
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents();
            
        }
        
        
    }
    // MARK: - Navigation

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        
        // this gets a reference to the screen that we're about to transition to, only do if os =>8.0
        
        if(iOSVersion.SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("8.0")){
            
            
            
            let toViewController = segue.destinationViewController as UIViewController
            
            // instead of using the default transition animation, we'll ask
            // the segue to use our custom TransitionManager object to manage the transition animation
            
            toViewController.transitioningDelegate = self.transitionManager
            
        }

        
    }


}

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
    
    
    
    
    
    // Views
    
    @IBOutlet weak var labelWelcomeUser: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // set up emailclient and label welcome
        
        if(isARegsiteredUser){
            
        
        labelWelcomeUser.text = "Welcome Back \(currentUserName)!";
            
    } else {
    
    labelWelcomeUser.text = "Welcome \(currentUserName)!";
    
    
    }
        
        
        arrayOfCoreDataCaseNumbers = getCaseNumbersFromCoreData();
        
        /*add a case to test corde dtabase here*/

        //writeToPracticeCoreData();
        
        arrayOfParseCaseNumbers = downloadCaseNumbersFromParse();
        
        
        
//        var lastCaseNuberFromParse : Int = arrayOfParseCaseNumbers.last!.toInt()!;
//        
//        var lastCaseNuberFromCore : Int = arrayOfCoreDataCaseNumbers.last!.toInt()!;
//        
//        
//        if(lastCaseNuberFromParse > lastCaseNuberFromCore){
//            
//            // write case from parse to core data
//            
//            loadCaseFromParseTo_CoreData();
//            
//            
//        }
        
        
        
    }// view did load
    
    
    func downloadCaseNumbersFromParse() -> Array<String>{
        
        // query parse case stidies class and get the case number query
        
        var loadParseToCore = false;
        
        //arrayParseCases : [String] = [""];
        
        var newCase = PFQuery(className:"TestCase");
        
        newCase.findObjectsInBackgroundWithBlock { (objects : [AnyObject]!, error: NSError!) -> Void in
            
            println("\n\nTHREAD - CASE FROM PARSE START\n\n");
            
            if error == nil{
                
                for theCase in objects{
                    
                    println("Case succesfully from Parse: \(theCase)");
                    
                    
                    let caseNumber = theCase["CaseNumber"] as String;
                    
                    self.arrayParseCases.append(caseNumber);
                    
                    
                }//for
                

            }//if nil
            
            
            /*Do this here instead of viewDidLoad as tasks run aysnchorouny*/
            
            var lastCaseNuberFromParse : Int = self.arrayParseCases.last!.toInt()!;
            
            
            if var lastCaseNuberFromCore : Int = self.arrayOfCoreDataCaseNumbers.last!.toInt(){
                
                println("Last case i core data = \(lastCaseNuberFromCore) Last case in Parse = \(lastCaseNuberFromParse)");
                
                if(lastCaseNuberFromParse > lastCaseNuberFromCore){
                    
                    // write case from parse to core data after gd task executes
                    
                    //self.loadCaseFromParseTo_CoreData();
                    
                    loadParseToCore = true;
                    
                    
                }

                
            
            }// if let
            else{
                
                println("Core Data Base empty");
            }
            
            
            
            
            println("\n\nTHREAD - CASE FROM PARSE FINISH \n\n");
            
            if(loadParseToCore){
                
                self.loadCaseFromParseTo_CoreData();
                
            }
        }// bgrd task
        
        
        
        return arrayParseCases;
        
        
    }// donloadFromParse
    
    
    
    
    
    
    func getCaseNumbersFromCoreData() -> Array<String>{
        
        // query core data stidies class and get the case number query
        var arrayCoreCases : [String] = [""];
        
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("TestParse", inManagedObjectContext: context) as NSManagedObject;
        
        var error : NSError? = nil;
        
        
        var request = NSFetchRequest(entityName: "TestParse");
        
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
                    if let tehCaseNumber : String = result.valueForKey("casenumber") as? String{
                        
                        arrayCoreCases.append(result.valueForKey("casenumber") as String);
                        
                        
                        
                        println("\n\nCOre data Case Numbers Array number = \(arrayCoreCases.count) and contents \(arrayCoreCases)\n\n");
                        
                    } else {
                        
                        println("No Data, no of entries = \(results?.count)");
                        
                        
                    } // else
                    
                }//!deleteFRomDA
                
            } // for


        
        
        return arrayCoreCases;
    }
    
    
    

    
    func loadCaseFromParseTo_CoreData(){
        
        // query Parse Object and load to core data
        
        println("Loading case from parse.....array Parse \(arrayOfParseCaseNumbers.count)");
        
        for caseNoInParseArray in arrayParseCases{
            
            var caseInteger = caseNoInParseArray.toInt();
            
            var lastCaseInCoreData = self.arrayOfCoreDataCaseNumbers.last?.toInt();
            
            println("Checking if case in Parse is greater than last case in Core, if so then download to core data..Last case in parse = \(caseInteger) Last case in core \(lastCaseInCoreData)");
            
            
            if(caseInteger > lastCaseInCoreData){
                
                /* write case from parse tro core data
                
                get context objxt and create a user entry with it*/
                
                var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
                
                var context : NSManagedObjectContext = appDel.managedObjectContext!;
                
                var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("TestParse", inManagedObjectContext: context) as NSManagedObject;
                
                var error : NSError? = nil;
                
                
                // Get pasre case
                
                var newCase = PFQuery(className:"TestCase");
                
                newCase.whereKey("CaseNumber", equalTo: caseNoInParseArray)
                
                newCase.findObjectsInBackgroundWithBlock { (objects : [AnyObject]!, error: NSError!) -> Void in
                    
                    println("\n\nTHREAD - CASE FROM PARSE TO CORE DATA START\n\n");
                    if error == nil{
                        
                        for theCase in objects{
                            
                            println("Case succesfully from Parse: \(theCase)");
                            
                            let imageName = theCase["image1"] as String;
                            let history = theCase["History"] as String;
                            let q1 = theCase["Question1"] as String;
                            let q2 = theCase["Question2"] as String;
                            let isCaseFromParse = theCase["IsParseCase"] as Bool;
                            
                            let caseNumber = theCase["CaseNumber"] as String;
                            
                            
                            //if(saveToDataBase){
                                
                                // Save from parse to core data Entty TestParse
                                newEntry3.setValue(history, forKey: "history");
                                newEntry3.setValue(q1, forKey: "q1");
                                newEntry3.setValue(q2, forKey: "q2");
                                newEntry3.setValue(caseNumber , forKey: "casenumber");
                            newEntry3.setValue(isCaseFromParse, forKey: "is_a_parsecase");
                            
                                println("\n\nCOMMIT STRIGS TO DATABASE\n\n");
                            
                            var error : NSError? = nil;
                            
                            context.save(&error);
                                
                           // }
                            //var error : NSError? = nil;
                            
                            // save to DB and handle error if present
                            // context.save(&error);
                            
                            
                            
                            var fileExtenion = "";
                            
                            let caseImageFile1 = theCase["image1File"] as PFFile
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
                                    
                                    newEntry3.setValue(imgaeURLName, forKey: "image1");
                                    
                                    context.save(&error);
                                    
                                    
                                    /*Make sure image is retrivable form directory of phone*/
                                    var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                                    
                                    println("\n\nThe image retruend from URL : \(coredDataImage.description)");
                                    
                                    
                                    println("\n\nTHREAD - FINISHED SAVING IMAGE1 FROM PARSE TO CORE\n");
                                    
                                
                                }
                            }// caseimage
                            
                            let caseImageFile2 = theCase["image2File"] as PFFile
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
                                    
                                    newEntry3.setValue(imgaeURLName, forKey: "image1");
                                    
                                    context.save(&error);
                                    
                                    var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                                    
                                    println("\n\nThe image retruend from URL : \(coredDataImage.description)");
                                    
                                    println("\n\nTHREAD - FINISHED SAVING IMAGE2 FROM PARSE TO CORE\n");
                           
                                    
                                    
                                }
                            }// caseimage
                            
                            let caseImageFile3 = theCase["image3File"] as PFFile
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
                                    
                                    newEntry3.setValue(imgaeURLName, forKey: "image1");
                                    
                                    context.save(&error);
                                    
                                    var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                                    
                                    println("\n\nThe image retruend from URL : \(coredDataImage.description)");
                                    
                                    println("\n\nTHREAD - FINISHED SAVING IMAGE3 FROM PARSE TO CORE\n");
                                    
                                    
                                    
                                }
                            }// caseimage
                            
                            let caseImageFile4 = theCase["image4File"] as PFFile
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
                                    
                                    newEntry3.setValue(imgaeURLName, forKey: "image1");
                                    
                                    context.save(&error);
                                    
                                    var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                                    
                                    println("\n\nThe image retruend from URL : \(coredDataImage.description)");
                                    
                                    println("\n\nTHREAD - FINISHED SAVING IMAGE FROM PARSE TO CORE\n");
                                }
                            
                            }
                            
                                    
                                    
                        } //for case in objects
                        
                        
                        
                        
                        
                        
                        
                    } else {
                        
                        println("Error retriving data form Parse : \(error)");
                        
                        self.displayAlert("Opps", message: "Soemthing went worig retriving new case study, please try later : \(error)");
                    }
                
                    println("\n\nTHREAD - CASE FROM PARSE TO CORE DATA FINISH - NOW CHECK CORED DATA FUNC CALL\n\n");
                    
                    self.checkCoreDataForNewCase();
                
            }// if
            
            
            
            
            
            
            /* update array of core data cases so include any new ones we have addaed from parse*/
            
            arrayOfCoreDataCaseNumbers = getCaseNumbersFromCoreData();
            
            
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
        
        var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("TestParse", inManagedObjectContext: context) as NSManagedObject;
        
        var error : NSError? = nil;
        
        
        var request = NSFetchRequest(entityName: "TestParse");
        
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
            }//for
            
                } else {
                    
                    println("No Data, no of entries = \(results?.count)");
                    
                    
                } // else
                
        
            
        } // method

        
    // GET IMAGE FROM CORE DATA DEBUGGING ONLY
    func loadImageFromPath(path : String) -> UIImage{
        
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
        newEntry3.setValue("Test History 1", forKey: "history");
        newEntry3.setValue("Test Question 1", forKey: "q1");
        newEntry3.setValue("Test Question 1", forKey: "q2");
        newEntry3.setValue("1" , forKey: "casenumber");
        newEntry3.setValue(false, forKey: "is_a_parsecase");
        
        println("\n\nADDING CASE  TO PRACTICE DARABASE \n\n");
        
        
        context.save(&error);

        
    }
   
    // MARK: - Navigation

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        
            // this gets a reference to the screen that we're about to transition to
        
            let toViewController = segue.destinationViewController as UIViewController
            
            // instead of using the default transition animation, we'll ask
            // the segue to use our custom TransitionManager object to manage the transition animation
            
            toViewController.transitioningDelegate = self.transitionManager

        
    }


}

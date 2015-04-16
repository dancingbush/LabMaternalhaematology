//
//  testParseCollectionViewViewController.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 12/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

/*Test VC with collection voew for dowcloading image files from parse and also save to code data as url*/

/*DO NOT SAVE A FULL DIR PATH TO CORE DATA, SAVE THE FILE/IMAGE NAME APPENDD TO THE DOCS DIRECTORRY, LOAD BACK THE SAM WYA, GET THE DOCS DIRECTPRY OF DEVICE IBDEPTENLTY ( SEE CODE ) THEN APPEND FILENAME FORM CORE DATA (STRING)*/

import UIKit
import CoreData


// DEBUGGING: New Device must clear core data base and enter new URLS for images on that device so, STE saveToDB TO FALSE WHEN RNNING ON A NEW DEVICE AS NEED THE TO DSAVE THE IMAGE DATA TO DOCS DIR - AND DELTE OBJECTS TO TRUE, THEW QUIT APP AND SET saveToDB = TRUE, delteObj = FALSE, THIS WILLS ET EVRTYHTING UP, QUIT AND NOW SET BOTH TO FALSE RUN AGAIN


var saveToDataBase = false; // false while delting DB contents
var deleteObjectsFromDB = false; // delte db contents = true

// Global methonds for getting directories to save images
func documentsDirectory() -> String {
    
    // Get the documents Directory for image url
    
    
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String;
    return documentsFolderPath
    
    
//    // Get path to the Documents Dir.
//    let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//    let documentsDir: NSString = paths.objectAtIndex(0) as NSString
    

    
}



func fileInDocumentsDirectory(filename: String) -> String {
    
    // Get path for a file in the directory
    
    return documentsDirectory().stringByAppendingPathComponent(filename);
    
    
}


class testParseCollectionViewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // feilds
    
    // Define the specific path, image name
    let imagePath = fileInDocumentsDirectory("");
    
    var imageNameToSaveURL = "";
    
    var questionAnsered : Bool = false; // true from detail zoom view when navigating back to this view so question not asjed again
    
    var theAnswer = "";
    
    var usersGuess = ""; // this determineddeping on th buttin pressed ie A B C or D
    
    
    
    let reuseIdentifier = "collCell";
    
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    
    //array to hold umage name from databse
    var arrayOfIUmages : [String] = [];
    
    var ArrayOfParseImages : [UIImage] = [];
    
    var arrayOfCoredataImage : [String] = []; //holds urls ro image
    
    
    
    
    var titles : [String] = [];
        
    
  
    
    @IBOutlet weak var testImagevIew: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var buttonA: UIButton!
    
    @IBOutlet weak var buttonB: UIButton!
    
    @IBOutlet weak var buttonC: UIButton!
    
    @IBOutlet weak var buttonD: UIButton!
    

    
    @IBAction func unwindToLayouController2(segue:UIStoryboardSegue) {
        
        //    method signaire name{segue:UIStoryboardSugue will
        //        allow any vc to naviagte/unwind to this vc when we drag a button to the 'Exit' on the vc
        
        // when we agcget back form zoom image we tell this that the questions has been asked!
        
        self.questionAnsered = true;
        
        
    }
    @IBAction func buttonA(sender: AnyObject) {
        
        println("ANSWER A CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "A";
        
        checkAnswer();
        
    }
    
    @IBAction func buttonB(sender: AnyObject) {
        
        println("ANSWER B CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "B";
        
        checkAnswer();
        
    }
    
    
    @IBAction func buttonC(sender: AnyObject) {
        
        println("ANSWER C CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "C";
        
        checkAnswer();
        
    }
    
    
    
    @IBAction func buttonD(sender: AnyObject) {
        
        
        println("ANSWER D CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "D";
        
        checkAnswer();
        
    }
    
    
    
    @IBAction func buttOnLargerImage(sender: AnyObject) {
        
        // navigate to detail controller for larger view
        
        self.performSegueWithIdentifier("segueToDetailView", sender: sender);
        
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
    
    
    func loadImageFromPath(path : String) -> UIImage{
        
        let image = UIImage(contentsOfFile: path); // returns an image from specofoed file (string)
        
        
        println("\n\nImage returned from File : \(image?.description)\n\n");
       
        
        if image == nil{
            
            println("No image loading form path : \(path)");
            
        }
        
        println("\n\nImage is stored in this location - can find in Finder: \(path)");
        
        return image!;
        
    }
    

    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get context objxt and create a user entry with it
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newEntry3 = NSEntityDescription.insertNewObjectForEntityForName("TestParse", inManagedObjectContext: context) as NSManagedObject;
        
        var error : NSError? = nil;
        
        
        
       // newEntry3.setValue(<#value: AnyObject?#>, forKey: <#String#>)
        //context.save(<#error: NSErrorPointer#>)
        //Fech request

        var request = NSFetchRequest(entityName: "TestParse");
        
        // for beta 4 xcode only
        request.returnsObjectsAsFaults = false;
        
        var results  = context.executeFetchRequest(request, error: nil);
        
        println("\n\nResults from DB \(results?.count) and teh results object \(results)\n\n");
        
        if results?.count > 1{
            
            
            
            
            for result : AnyObject in results! {
                
                
                println("Database object form parse: \(result.count) and contents : \(result.description)");
                
                
//                // delet object and save for debugging
                
                if(deleteObjectsFromDB){
                    
                    context.deleteObject(result as NSManagedObject);
                    
                    
                    
                    
                    context.save(&error);
                    
                    println("DELETED CORE DATA OBJECT : \(result)");
                    
                }else if(!deleteObjectsFromDB){
                  
                
                // Save to arrays only of a value exists ie not == nil
                if let tehCaseNumber : String = result.valueForKey("casenumber") as? String{
                    
                    arrayOfCoredataImage.append(result.valueForKey("image1") as String);
                     arrayOfCoredataImage.append(result.valueForKey("image2") as String);
                     arrayOfCoredataImage.append(result.valueForKey("image3") as String);
                     arrayOfCoredataImage.append(result.valueForKey("image4") as String);
                    
                   // buttonA.setTitle(result.valueForKey, forState: <#UIControlState#>)
                    
                    var history = result.valueForKey("history") as? String
                    var quest1 = result.valueForKey("q1") as? String
                    var quest2 = result.valueForKey("q2") as? String

                    println("\n\nCOre data URL Array number = \(arrayOfCoredataImage.count) and contents \(arrayOfCoredataImage)\n\n");
                //}
//                if let caseNum : String = result.valueForKey("caseNumber") as? String{
//                    
//                    if (caseNum == theCase){
//                        
//                        
//                        println("Getting Case \(caseNum) from DB");
//                        
//                        println(result);
//                    }
                
                //}
        } else {
            
            println("No Data, no of entries = \(results?.count)");
 
            
            } // else
                
                 }//!deleteFRomDA
            
            } // for
            
        }
        
   
        
        


        // Get data from Parse and save core data, save images as a URL to docs dircetoty in phone and save the URL to core data
        
        var newCase = PFQuery(className:"TestCase");
        
        newCase.findObjectsInBackgroundWithBlock { (objects : [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil{
                
                for theCase in objects{
                    
                    println("Case succesfully from Parse: \(theCase)");
                    
                    let imageName = theCase["image1"] as String;
                    let history = theCase["History"] as String;
                    let q1 = theCase["Question1"] as String;
                    let q2 = theCase["Question2"] as String;
                    
                    let caseNumber = theCase["CaseNumber"] as String;
                    
                    
                     if(saveToDataBase){
                    
                    // Save from parse to core data Entty TestParse
                    newEntry3.setValue(history, forKey: "history");
                    newEntry3.setValue(q1, forKey: "q1");
                    newEntry3.setValue(q2, forKey: "q2");
                    newEntry3.setValue(caseNumber , forKey: "casenumber");
                        println("COMMIT STRIGS TO DATABASE");
                    
                    }
                    //var error : NSError? = nil;
                    
                     // save to DB and handle error if present
                   // context.save(&error);
                    
                    
                    
                    var fileExtenion = "";
                    
                    let caseImageFile1 = theCase["image1File"] as PFFile
                    caseImageFile1.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            
                            let image = UIImage(data:imageData)
                            
                            self.ArrayOfParseImages.append(image!);
                            
                                                        println("Images Array from Parse Count: \(self.ArrayOfParseImages.count) ")
                            
                            self.collectionView.reloadData();
                            
                            
                            // Get url of image from data from parse so we can check if t os a png or jpeg extensiom
                            
                            let imageURLFromParse = caseImageFile1.url;
                            
                            //let imageURLFromParse = NSURL(string : caseImageFile1.url);
                            
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
                            var imgaeURLName = "Case\(caseNumber)a\(fileExtenion)";
                            
                            
                            // Save as URL ro phone and then to core data as URL string
                            
                            
                            var filePath = fileInDocumentsDirectory(imgaeURLName);
                            
                            println("\n\nSAVING image to directory : \(filePath)");
                            
                            self.saveImageToDirectory(image!, path: filePath, imageType: fileExtenion);
                            
                            
                            
                            
                            // save to core data object : Only Save the image name and not full path as will not reload properly after quiting and starting app!! When we reload image we just get the path from functions and appedn the imagename form core data
                            
                           // newEntry3.setValue(filePath, forKey: "image1");
                            
                           
                            
                            // Afterpopulating array of URLS for core data for a given case, Load image back form url, this will be in populating voews in collection voew
                            
                            //var coredDataImage : UIImage =  self.loadImageFromPath(filePath);
                            
                            var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                            
                            println("The image retruend from URL : \(coredDataImage.description)");
                            
                            var error : NSError? = nil;
                            
                            if(saveToDataBase){
                                
                            
                             newEntry3.setValue(imgaeURLName, forKey: "image1");
                                
                           context.save(&error);
                                
                                println("\n\nCOMMIT IMAGE1 URL TO DATABASE\n\n");
                            }
                            
                            //load the image 
                            //self.testImagevIew.image = coredDataImage;
                            
                            
                            
                            
                        }
                    }// caseimage
                    
                    let caseImageFile2 = theCase["image2File"] as PFFile
                    caseImageFile2.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            let image = UIImage(data:imageData)
                            self.ArrayOfParseImages.append(image!);
                            
                            println("Images Array from Parse Count: \(self.ArrayOfParseImages.count) ")
                            
                           self.collectionView.reloadData();
                            
                            
//                            You have to use NSURL(string: "yoururl")!.pathExtension the parse url property actually returns a string so you need to convert it to NSURL if the url points to a local resource you need to use NSURL(fileURLWithPath)
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
                            
                            
                            
                            
                            // save to core data object : Only Save the image name and not full path as will not reload properly after quiting and starting app!! When we reload image we just get the path from functions and appedn the imagename form core data
                            
                            // newEntry3.setValue(filePath, forKey: "image1");
                            
                            
                            // Afterpopulating array of URLS for core data for a given case, Load image back form url, this will be in populating voews in collection voew
                            
                            //var coredDataImage : UIImage =  self.loadImageFromPath(filePath);
                            
                            var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                            
                            println("The image retruend from URL : \(coredDataImage.description)");
                            
                            var error : NSError? = nil;
                            
                            if(saveToDataBase){
                                
                                
                                newEntry3.setValue(imgaeURLName, forKey: "image2");

                                context.save(&error);
                                
                                println("\n\\nCOMMIT IMAGE2 URL TO DATABASE");
                            }

                            
                        }
                    }// caseimage

                    let caseImageFile3 = theCase["image3File"] as PFFile
                    caseImageFile3.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            let image = UIImage(data:imageData)
                            self.ArrayOfParseImages.append(image!);
                            
                            println("Images Array from Parse Count: \(self.ArrayOfParseImages.count) ")
                            
                            self.collectionView.reloadData();
                            
                            
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
                            
                            // newEntry3.setValue(filePath, forKey: "image1");
                            
                            
                            // Afterpopulating array of URLS for core data for a given case, Load image back form url, this will be in populating voews in collection voew
                            
                            //var coredDataImage : UIImage =  self.loadImageFromPath(filePath);
                            
                            var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                            
                            println("The image retruend from URL : \(coredDataImage.description)");
                            
                            var error : NSError? = nil;
                            
                            if(saveToDataBase){
                                
                                newEntry3.setValue(imgaeURLName, forKey: "image3");

                                
                                context.save(&error);
                                
                                println("\n\nCOMMIT IMAGE3 URL TO DATABASE\n");
                            }
                            
                        }
                    }// caseimage

                    let caseImageFile4 = theCase["image4File"] as PFFile
                    caseImageFile4.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            let image = UIImage(data:imageData)
                            self.ArrayOfParseImages.append(image!);
                            
                            println("Images Array from Parse Count: \(self.ArrayOfParseImages.count) ")
                            
                            self.collectionView.reloadData();
                            
                            
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
                            
                            // newEntry3.setValue(filePath, forKey: "image1");
                            
                            
                            // Afterpopulating array of URLS for core data for a given case, Load image back form url, this will be in populating voews in collection voew
                            
                            //var coredDataImage : UIImage =  self.loadImageFromPath(filePath);
                            
                            var coredDataImage : UIImage =  self.loadImageFromPath(fileInDocumentsDirectory(imgaeURLName));
                            
                            println("The image retruend from URL : \(coredDataImage.description)");
                            
                            var error : NSError? = nil;
                            
                            if(saveToDataBase){
                                
                                newEntry3.setValue(imgaeURLName, forKey: "image4");

                                
                                
                                context.save(&error);
                                
                                println("\n\nCOMMIT IMAGE4 URL TO DATABASE\n\n");
                            }
                            
                        }
                    }// caseimage

                    //self.collectionView.reloadData();
                    
                } //for case in objects
                
                self.collectionView.reloadData();
                

                    
                
                
            } else {
                
                println("Error retriving data form Parse : \(error)")
            }
            
            //self.collectionView.reloadData();
        }
        
            
        
        
        
//        let imageView = PFImageView()
//        imageView.image = UIImage(named: "...") // placeholder image
//        //imageView.file = someObject.picture // remote image
//        imageView.file =
//        imageView.loadInBackground()
//        
        // If navogating from zoom view we should see our qusetionAnswered = true
        println(self.questionAnsered);
        
        
        //self.collectionView
        
        theAnswer = question1_answer;
        
        
        arrayOfIUmages = [questoin1Image1, question1Image2, question1Image3, question1Image4 ];
        
        titles = [questoin1Image1Description,questoin1Image2Description,questoin1Image3Description,  questoin1Image4Description ];
        
        scrollView.contentSize = self.view.frame.size;
        //scrollView.addSubview(imageView)
        scrollView.scrollEnabled = true;
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clearColor()
        
        // buttonAnswer1.setTitle(option1, forState: UIControlState.Normal);
        
        buttonA.setTitle(question1OptionA , forState: .Normal);
        buttonA.backgroundColor = UIColor.whiteColor()
        buttonA.layer.cornerRadius = 5
        buttonA.layer.borderWidth = 1
        buttonA.layer.borderColor = UIColor.blackColor().CGColor
        
        
        buttonB.setTitle(question1OptionB, forState: .Normal);
        buttonB.backgroundColor = UIColor.whiteColor()
        buttonB.layer.cornerRadius = 5
        buttonB.layer.borderWidth = 1
        buttonB.layer.borderColor = UIColor.blackColor().CGColor
        
        buttonC.setTitle(question1OptionC, forState: .Normal);
        buttonC.backgroundColor = UIColor.whiteColor()
        buttonC.layer.cornerRadius = 5
        buttonC.layer.borderWidth = 1
        buttonC.layer.borderColor = UIColor.blackColor().CGColor
        
        
        buttonD.setTitle(question1OptionD, forState: .Normal);
        buttonD.backgroundColor = UIColor.whiteColor()
        buttonD.layer.cornerRadius = 5
        buttonD.layer.borderWidth = 1
        buttonD.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        //return 50
        
        return arrayOfIUmages.count;
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as CollectionViewCell;
        
        println("The Cell \(cell)");
        
        // check any omage sin array form parse first if not load elsewhere
        
        
//        if(ArrayOfParseImages.count > 1){
//            
//            cell.pinImage2.image = ArrayOfParseImages[indexPath.row];
        
        // get from url stored in core data
        
        if(arrayOfCoredataImage.count > 1) {
            
            var imageURL = arrayOfCoredataImage[indexPath.row]
            
            println("\n\n\nCollection View Image URL from cor dta filePath: \(imageURL)\n");
            
            
            var filePath = fileInDocumentsDirectory(imageURL);
            
            var coredDataImage : UIImage =  self.loadImageFromPath(filePath);
            
            println("The image retruend from URL : \(coredDataImage.description)");
            
            cell.pinImage2.image = coredDataImage;
            
            
        } else {
            
            var imageName = arrayOfIUmages[indexPath.row];
            
            if let imageToAdd = UIImage(named: self.arrayOfIUmages[indexPath.row]){
                
                cell.pinImage2.image = UIImage(named: self.arrayOfIUmages[indexPath.row]);
                
            } else{
                
                cell.pinImage2.image = UIImage(named: "microscope.jpg");
                
                cell.title2?.text = "No Image."
            }

        }
        
        
        
        var titleName = titles[indexPath.row];
        
        //println("Image Name : \(imageName) \n Title Name : \(titleName)Cell image : ");
        
        /* If we return null for an image or titke must place placeholder omages by lazy intialisation*/
        
        cell.title2.text? = self.titles[indexPath.row];
        
        
        //cell.pinImage2.image = UIImage(named: self.arrayOfIUmages[indexPath.row]);
        
        //cell.pinImage.image = UIImage(named: imgName)
        
        return cell
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            return CGSize(width: 170, height: 300)
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(collection: UICollectionView, selectedItemIndex: NSIndexPath)
    {
        //As sender send any data you need from the current Selected CollectionView
        self.performSegueWithIdentifier("segueToDetailView", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(segue.identifier)
        println(sender)
        
        
        //        if(segue.identifier == "detail"){
        //
        
        // first one orginal
        
        // }
        
        println("SEGUE SELECTED:  \(segue.identifier)");
        
        if(segue.identifier == "segueToDetailScrollView"){
            
            // pass the cell
            
            
            let cell = sender as CollectionViewCell;
            
            let indexPath = collectionView?.indexPathForCell(cell);
            
            //let vc = segue.destinationViewController as DetailViewController;
            
            
            //alterante viewcontroller object with black background
            
            //let vc = segue.destinationViewController as DetailViewController;
            
            let vc = segue.destinationViewController as ScrollView;
            
            var image = arrayOfIUmages[indexPath!.row];
            
            var imageTitle = titles[indexPath!.row];
            
            println("Image to segue name : \(image) and the title : \(imageTitle)");
            
            
            println("The vew controller \(vc)");
            
            vc.currImage = UIImage(named: arrayOfIUmages[indexPath!.row]);
            vc.textHeading = self.titles[indexPath!.row];
            
            
        }
    }
    
    
    func checkAnswer() -> Bool {
        
        // rerurns a bool to boutton pressed of anser is correct and in button pressed we change teh buttons colour and deactivare all pther bittons here also
        
        var isAnswerCorrect:Bool;
        
        
        if(usersGuess == theAnswer){
            
            
            isAnswerCorrect = true;
            
            numberOfCorrectANswers = "1";
            
            switch theAnswer {
                
            case "A":
                
                
                // mySampleColorButton.backgroundColor = UIColor(red: 0.5, green: 128/255.0, blue: 0.5, alpha: 1.0) //10
                
                
                buttonA.backgroundColor = UIColor(red: 70/255.0, green: 243/255.0, blue: 58/255.0, alpha: 0.75);
                
                buttonA.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                usersAnsersToAllQuestions = usersAnsersToAllQuestions + buttonA.titleLabel!.text! + " - Correct!";
                
                
            case "B":
                
                //buttonB.backgroundColor = UIColor.greenColor();
                
                buttonB.backgroundColor = UIColor(red: 70/255.0, green: 243/255.0, blue: 58/255.0, alpha: 0.75);
                
                buttonB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                usersAnsersToAllQuestions = usersAnsersToAllQuestions + buttonB.titleLabel!.text! + " - Correct!";
                
            case "C":
                
                buttonC.backgroundColor = UIColor(red: 70/255.0, green: 243/255.0, blue: 58/255.0, alpha: 0.75);
                
                buttonC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                usersAnsersToAllQuestions = usersAnsersToAllQuestions + buttonC.titleLabel!.text! + " - Correct!";
                
            case "D":
                
                buttonD.backgroundColor = UIColor(red: 70/255.0, green: 243/255.0, blue: 58/255.0, alpha: 0.75);
                
                buttonD.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                usersAnsersToAllQuestions = usersAnsersToAllQuestions + buttonD.titleLabel!.text! + " - Correct!";
                
            default:
                
                println("Default");
                
            } // switch
            
        }else {
            
            // the answer is wrong so highlight the usersChoice red and the correct anser green
            
            isAnswerCorrect = false;
            
            numberOfIncorrectAnswers = "1";
            
            
            switch usersGuess {
                
            case "A":
                
                usersAnsersToAllQuestions = usersAnsersToAllQuestions + buttonA.titleLabel!.text! + " - InCorrect!";
                
                
                buttonA.backgroundColor = UIColor(red: 246/255.0, green: 54/255.0, blue: 15/255.0, alpha: 0.75);
                
                buttonA.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                
            case "B":
                
                usersAnsersToAllQuestions = usersAnsersToAllQuestions + buttonB.titleLabel!.text! + " - InCorrect!";
                //buttonB.backgroundColor = UIColor.redColor();
                buttonB.backgroundColor = UIColor(red: 246/255.0, green: 54/255.0, blue: 15/255.0, alpha: 0.75);
                
                buttonB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "C":
                
                usersAnsersToAllQuestions = usersAnsersToAllQuestions + buttonC.titleLabel!.text! + " InCorrect!";
                
                buttonC.backgroundColor = UIColor(red: 246/255.0, green: 54/255.0, blue: 15/255.0, alpha: 0.75);
                
                buttonC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "D":
                
                
                usersAnsersToAllQuestions = usersAnsersToAllQuestions + buttonD.titleLabel!.text! + " - InCorrect!";
                
                buttonD.backgroundColor = UIColor(red: 246/255.0, green: 54/255.0, blue: 15/255.0, alpha: 0.75);
                
                buttonD.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            default:
                
                println("Default");
            } // switch
            
            
            // now turn the correct btton green
            switch theAnswer {
                
            case "A":
                
                //buttonA.backgroundColor = UIColor.greenColor();
                
                buttonA.backgroundColor = UIColor(red: 70/255.0, green: 243/255.0, blue: 58/255.0, alpha: 0.75);
                
                buttonA.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                
            case "B":
                
                //buttonB.backgroundColor = UIColor.greenColor();
                
                buttonB.backgroundColor = UIColor(red: 70/255.0, green: 243/255.0, blue: 58/255.0, alpha: 0.75);
                
                buttonB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "C":
                //buttonC.backgroundColor = UIColor.greenColor();
                buttonC.backgroundColor = UIColor(red: 70/255.0, green: 243/255.0, blue: 58/255.0, alpha: 0.75);
                
                buttonC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "D":
                
                //buttonD.backgroundColor = UIColor.greenColor();
                
                buttonD.backgroundColor = UIColor(red: 70/255.0, green: 243/255.0, blue: 58/255.0, alpha: 0.75);
                
                buttonD.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            default:
                
                println("Default");
                
            } // switch iwthin the else ianswer ncoorect statement to check which button had the right amswer
            
            
            
            
            
            
            
        }// if else
        
        dissAbleAllButtons();
        
        
        
        
        println("USER NASWER 1 = \(usersAnsersToAllQuestions)\nNO OF CORRECT-IN ANSWER = \(numberOfCorrectANswers) : \(numberOfIncorrectAnswers)");
        
        
        
        return isAnswerCorrect;
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    
    
    func dissAbleAllButtons() {
        
        // called from checkAnswer
        
        buttonA.enabled = false;
        buttonB.enabled = false;
        buttonC.enabled = false;
        buttonD.enabled = false;
    }
    

}

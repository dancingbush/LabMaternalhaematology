//
//  LayoutController2.swift
//  PinterestLayout
//
//  Created by Ciaran Mooney on 13/03/2015.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

/*

For second type of collection view with delage data source collection subview ro viewcontroller
, conatins a scollvoew wrapping a collection vew and other voew wth buttons 
*/


import UIKit
import Foundation

class LayoutController2 : UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {

    
    // feilds
    
    var questionAnsered : Bool = false; // true from detail zoom view when navigating back to this view so question not asjed again
    
    var theAnswer = "";
    
    var usersGuess = ""; // this determineddeping on th buttin pressed ie A B C or D
    
    

   let reuseIdentifier = "collCell";
    
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    
    //array to hold umage name from databse
    var arrayOfIUmages : [String] = [];
    //let arrayOfIUmages = ["case1.jpg", "case1b.jpg", "case2a.jpg", "case2b.jpg", "case2c.jpg", "case3.jpg", "case3a.jpg"];
    
    
    // titles from databse attribut Imagfe descroption:String
    var titles : [String] = [];
    //let titles = ["ALL x40","HDN x40","Oil","x20 Micrsopy","H&E", "H&E", "H&E", "H&E"];
    
    
    //Views get the collecyionView and the colection view cell
//    @IBOutlet var collectionView : UICollectionView!
//    @IBOutlet var layout : UICollectionViewFlowLayout
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!

    //@IBOutlet weak var collectionViewCell: CollectionViewCell!
    
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
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        
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
        
        var imageName = arrayOfIUmages[indexPath.row];
        
        var titleName = titles[indexPath.row];
        
        println("Image Name : \(imageName) \n Title Name : \(titleName)Cell image : ");
        
        /* If we return null for an image or titke must place placeholder omages by lazy intialisation*/
        
        cell.title2.text? = self.titles[indexPath.row];
        
        if let imageToAdd = UIImage(named: self.arrayOfIUmages[indexPath.row]){
            
             cell.pinImage2.image = UIImage(named: self.arrayOfIUmages[indexPath.row]);
            
        } else{
            
            cell.pinImage2.image = UIImage(named: "microscope.jpg");
            
            cell.title2?.text = "No Image."
        }
        
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

//

}

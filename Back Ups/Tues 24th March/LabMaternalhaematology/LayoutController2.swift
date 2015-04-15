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
    
    var theAnswer = "B"; // we will get this from the databse, so Button B is correct answer
    
    var usersGuess = ""; // this determineddeping on th buttin pressed ie A B C or D
    
    //var imageSize = CGSizeMake(0,0); // for zooming reset

   let reuseIdentifier = "collCell";
    
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    
    //array to hold umage name from databse
    let arrayOfIUmages = ["case1.jpg", "case1b.jpg", "case2a.jpg", "case2b.jpg", "case2c.jpg", "case3.jpg", "case3a.jpg"];
    
    
    // titles from databse attribut Imagfe descroption:String
    let titles = ["ALL x40","HDN x40","Oil","x20 Micrsopy","H&E", "H&E", "H&E", "H&E"];
    
    
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
    
    
    @IBAction func buttonA(sender: AnyObject) {
        
        println("ANSWER B CHOSEN");
        
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
        
        println("ANSWER B CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "C";
        
        checkAnswer();

    }
    
    
    
    @IBAction func buttonD(sender: AnyObject) {
        
        
        println("ANSWER B CHOSEN");
        
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
        
        //self.collectionView
        
        scrollView.contentSize = self.view.frame.size;
        //scrollView.addSubview(imageView)
        scrollView.scrollEnabled = true;

        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clearColor()
        
        buttonA.backgroundColor = UIColor.whiteColor()
        buttonA.layer.cornerRadius = 5
        buttonA.layer.borderWidth = 1
        buttonA.layer.borderColor = UIColor.blackColor().CGColor
        
        
        buttonB.backgroundColor = UIColor.whiteColor()
        buttonB.layer.cornerRadius = 5
        buttonB.layer.borderWidth = 1
        buttonB.layer.borderColor = UIColor.blackColor().CGColor
        
        
        buttonC.backgroundColor = UIColor.whiteColor()
        buttonC.layer.cornerRadius = 5
        buttonC.layer.borderWidth = 1
        buttonC.layer.borderColor = UIColor.blackColor().CGColor
        
        
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
        //cell.title.text = self.titles[indexPath.row % 5]
        cell.title2.text? = self.titles[indexPath.row];
        
        //let curr = indexPath.row % 5  + 1
        //let imgName = "pin\(curr).jpg"
        
        cell.pinImage2.image = UIImage(named: self.arrayOfIUmages[indexPath.row]);
        
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
            
            //vc.myImageView.image = currImage;
            
            
            
            //let cell = sender as CollectionViewCell
            //let indexPath = collectionView?.indexPathForCell(cell)
            //let vc = segue.destinationViewController as DetailViewController
            
            //            let curr = indexPath!.row % 5  + 1
            //            let imgName = "pin\(curr).jpg"
            //
            //            println(vc)
            //            vc.currImage = UIImage(named: imgName)
            //            vc.textHeading = self.titles[indexPath!.row % 5]
            //
            //            vc.heading.text = self.titles[0]
            // vc.imageView.image = UIImage(named: imgName)
        }
    }

    
    func checkAnswer() -> Bool {
        
        // rerurns a bool to boutton pressed of anser is correct and in button pressed we change teh buttons colour and deactivare all pther bittons here also
        
        var isAnswerCorrect:Bool;
        
        
        if(usersGuess == theAnswer){
            
            isAnswerCorrect = true;
            
            switch theAnswer {
                
            case "A":
                
                buttonA.backgroundColor = UIColor.greenColor();
                buttonA.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                
            case "B":
                
                buttonB.backgroundColor = UIColor.greenColor();
                buttonB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "C":
                buttonC.backgroundColor = UIColor.greenColor();
                buttonC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "D":
                
                buttonD.backgroundColor = UIColor.greenColor();
                buttonD.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            default:
                
                println("Default");
                
            } // switch
            
        }else {
            
            // the answer is wrong so highlight the usersChoice red and the correct anser green
            
            isAnswerCorrect = false;
            
            switch usersGuess {
                
            case "A":
                
                buttonA.backgroundColor = UIColor.redColor();
                buttonA.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                
            case "B":
                
                buttonB.backgroundColor = UIColor.redColor();
                buttonB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "C":
                buttonC.backgroundColor = UIColor.redColor();
                buttonC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "D":
                
                buttonD.backgroundColor = UIColor.redColor();
                buttonD.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            default:
                
                println("Default");
            } // switch
            
            
            // now turn the correct btton green
            switch theAnswer {
                
            case "A":
                
                buttonA.backgroundColor = UIColor.greenColor();
                buttonA.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
                
            case "B":
                
                buttonB.backgroundColor = UIColor.greenColor();
                buttonB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "C":
                buttonC.backgroundColor = UIColor.greenColor();
                buttonC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            case "D":
                
                buttonD.backgroundColor = UIColor.greenColor();
                buttonD.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            default:
                
                println("Default");
                
            } // switch iwthin the else ianswer ncoorect statement to check which button had the right amswer
            
            
            
            
            
            
            
        }// if else
        
        dissAbleAllButtons();
        
        
        
        
        
        
        
        return isAnswerCorrect;
        
        
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

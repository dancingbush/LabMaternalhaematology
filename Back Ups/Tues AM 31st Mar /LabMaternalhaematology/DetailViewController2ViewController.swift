//
//  DetailViewController2ViewController.swift
//  PinterestLayout
//
//  Created by Ciaran Mooney on 12/03/2015.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

/*

With black background
zooming tut here http://makeapppie.com/2014/12/11/swift-swift-using-uiscrollview-with-autolayout/
*/

import UIKit

class DetailViewController2ViewController: UIViewController, UIScrollViewDelegate {

    // feilds
    
    var theAnswer = "B"; // we will get this from the databse, so Button B is correct answer
    
    var usersGuess = ""; // this determineddeping on th buttin pressed ie A B C or D
    
    //var imageSize = CGSizeMake(0,0); // for zooming reset
    
    
    
    @IBOutlet weak var buttonA: UIButton!
    
    @IBAction func buttonA(sender: AnyObject) {
        
        
        usersGuess = "A";
        
        checkAnswer();
    }
    
    
    @IBOutlet weak var buttonB: UIButton!
    
    
    @IBAction func buttunB(sender: AnyObject) {
        
        println("ANSWER B CHOSEN");
        
        // if anser correct then change colour of button to grren
        
        usersGuess = "B";
        
        checkAnswer();
        
//        var isAnswerCorrect = self.checkAnswer();
//        
//        if(isAnswerCorrect){
//            
//            buttonB.backgroundColor = UIColor.greenColor();
//            //buttonB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
//            buttonB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        }
        
        
    }
    
    
    @IBOutlet weak var buttinC: UIButton!
   
    
    @IBAction func buttonC(sender: AnyObject) {
        
        
        usersGuess = "C";
        
        checkAnswer();
    }
    
    
    @IBOutlet weak var buttonD: UIButton!
    
    
    
    @IBAction func buttonD(sender: AnyObject) {
        
        
        usersGuess = "D";
        
        checkAnswer();
    }
  
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var myImageView: UIImageView!
    // this varibels are assigned in the segue fro LayoutCollectionVoew
    var currImage: UIImage?
    var textHeading: String?
    
    
    
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
            buttinC.backgroundColor = UIColor.greenColor();
            buttinC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
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
                buttinC.backgroundColor = UIColor.redColor();
                buttinC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
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
                buttinC.backgroundColor = UIColor.greenColor();
                buttinC.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
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
        buttinC.enabled = false;
        buttonD.enabled = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        println("Detail view controller 2");
        
        //myLabel.text = textHeading
        
        myImageView.image = currImage;
        
        
        
        // set scorllable propertues and its comtent size to allow zooming n the image
        scrollView.contentSize = myImageView.frame.size;
        //scrollView.addSubview(imageView)
        scrollView.scrollEnabled = true;
        
//        //zooming photo
//        imageSize = myImageView.frame.size
//        scrollView.delegate = self
//        //scrollView.addSubview(imageView)
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
        
        //scrollView.setcontents
        
         //cutomise buttons and scrollview

        scrollView.backgroundColor = UIColor.clearColor();
        
        buttonA.backgroundColor = UIColor.whiteColor()
        buttonA.layer.cornerRadius = 5
        buttonA.layer.borderWidth = 1
        buttonA.layer.borderColor = UIColor.blackColor().CGColor
        
        
        buttonB.backgroundColor = UIColor.whiteColor()
        buttonB.layer.cornerRadius = 5
        buttonB.layer.borderWidth = 1
        buttonB.layer.borderColor = UIColor.blackColor().CGColor
        
        
        buttinC.backgroundColor = UIColor.whiteColor()
        buttinC.layer.cornerRadius = 5
        buttinC.layer.borderWidth = 1
        buttinC.layer.borderColor = UIColor.blackColor().CGColor
        
        
        buttonD.backgroundColor = UIColor.whiteColor()
        buttonD.layer.cornerRadius = 5
        buttonD.layer.borderWidth = 1
        buttonD.layer.borderColor = UIColor.blackColor().CGColor
        
        
        
        
        
       
    }
    
    override func viewDidLayoutSubviews() {
        
//        Line 2 sets the maximum zoom scale. I used an arbitrary value of five times the size of the image. I then set the content size. As we’ve already said, the scroll view needs this, but we are keeping the size under control by using a constant, since the content view changes when we rotate the view, and can mess up our calculations. Next we figure the scale by taking the bounds of the scroll View, which by now are correct since auto layout is done with them. We see if the widthScale or heightScale is smaller, and use that scale as the one for our minimum zoom scale. We then set the scale for the scroll view as the minimum zoom scale. You can do a lot with this code and modify it a lot of different ways for different scale effects. This is the basics.
        
        
//        scrollView.maximumZoomScale = 5.0
//        scrollView.contentSize = imageSize
//        let widthScale = scrollView.bounds.size.width / imageSize.width
//        let heightScale = scrollView.bounds.size.height / imageSize.height
//        scrollView.minimumZoomScale = min(widthScale, heightScale)
//        scrollView.setZoomScale(max(widthScale, heightScale), animated: true )
    }
    
    
    //MARK: Delegates
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        
////        Our last step is to set up the delegate, which is a quick one. It just wants the view we are zooming to return to the delegate
//        return myImageView;
//    }
    
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

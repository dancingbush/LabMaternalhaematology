//
//  Summary.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 22/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

/*
We need globals for all user answers, the number pf correct
    number of incorrect

NOTE IF image not fitting the voiew correctly slectes Clip Subviews in Attributes inspector and Aspect Fill

*/

import UIKit

class Summary: UIViewController {
    
    
    
    // Instances
    var timer = NSTimer();
    
    var summary = "Micrscopy: AML\nFurther Tests : Cytogentics\nDiagnosis: TAM\n\nYou answerd\nMicrsopy: Acthancytes\nAppropiate Tests: Bone Marrow\nDiagnssis: AML\n\nTAM is a clicncal diagnosis usually asscoated wityhe Trsiomy 21. It is sef lemiting and often assocatied wth M6, meagkarocytic linage. Most resvole spontanpusely but may re-occur as a ALL or AML at 2 years of life.";
    
    var caseNumber = 1; //get from global
    var result = "Average";
    var frameNumber = 1; //animations
    
    
    
    //Views
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var labelCaseNumber: UILabel!
    
    
    @IBOutlet weak var labelCorrectAnswers: UILabel!
    
    
    @IBOutlet weak var labelInCorrectAnswers: UILabel!
    
    
    
    @IBOutlet weak var labelResult: UILabel!
    
    

    @IBOutlet weak var textFieldSummary: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // animate image
        // run animate function every 0.1 of second
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:  Selector ("animate"), userInfo: nil, repeats: true);
        
        // USe attribured strings to add to summary
        let labelFont = UIFont(name: "HelveticaNeue-Bold", size: 14)
        let attributes = [NSFontAttributeName : labelFont!]
        var attrString = NSMutableAttributedString(string: "Correct Answers:\n\n", attributes: attributes)
        let newString = NSAttributedString(string: self.summary);
        attrString.appendAttributedString(newString)
        println(attrString.description)
        textFieldSummary.attributedText = attrString;
        
        
        labelCaseNumber.text = "1";
        labelCorrectAnswers.text = "1";
        labelInCorrectAnswers.text = "1";
        
        setImageAndResult();
        
        
        //textFieldSummary.text = attrString  + summary;
        //textFieldSummary.text = summary;
        
    
        //labelResult.text = result;
    }
    
    override func viewDidLayoutSubviews() {
        //before subviews loaded we will hide the image view to the left off screen
        
        self.imageView.frame = CGRectMake(80, 20, 0, 0);
    }
    
    override func viewDidAppear(animated: Bool) {
        // after views have been downloaded slowlu move image view to center pf screen
        
        UIView.animateWithDuration(3, animations: { () -> Void in
            self.imageView.frame = CGRectMake(40, 70, 320, 150); //x,y,width, height
        });
    
    }
    
    
    func animate(){
        
        //change image in imageview every time thi fucn called by NSTimer in viewDidlOad
        
        if(frameNumber>2){
            
            frameNumber=1;//only have two images to aniamte
        }
        
        let frame2 = UIImage(named: "oldpeople\(frameNumber)");
        
        imageView.image = frame2;
        
        frameNumber++;
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setImageAndResult(){
        
        
        // set image first
        
        var noOfCorrectAnwsers = labelCorrectAnswers.text!;
        
        
        
        switch noOfCorrectAnwsers {
        
        case "1":
            
            imageView.image = UIImage(named: "splash");
            
            labelResult.text = "Poor!";
            
            println("Image set to 1 Correct Answer");
            
        case "2":
            
            imageView.image = UIImage(named: "pizza");
            
            labelResult.text = "Good!";
            
            println("Image set to 2 Correct Answer");

        default:
            
            imageView.image = UIImage(named: "default-placeholder");
            
            labelResult.text = "Perfect!";
            
            println("Image set to 3 Correct Answer");
            
        }// swict
        
        
               }// setIMage

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ScrollView.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 09/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//


/*
Tutorial for horizonta button and Image zoom view
http://makeapppie.com/2014/12/11/swift-swift-using-uiscrollview-with-autolayout/

For simple scrollvoiew with no images https://www.youtube.com/watch?v=4oCWxHLBQ-A

Remeber to set the scrollview delage to the viewcontroller by dragging ot viewcontrolling and - Dlegate (like tableview)


You can simulate the 'pinch to zoom' gesture of the iPhone in Apple's Aspen Simulator by holding down the Option key while clicking the mouse in the area you wish to pinch. This brings up a pair of dots that represent your fingertips.
*/


import UIKit

class ScrollView: UIViewController, UIScrollViewDelegate {

    
    // insances
    
    var imageSize = CGSizeMake(0, 0); // when devoce rotated needed o reset   
    
    @IBOutlet weak var buttonScrollView: UIScrollView!
    
    
//    @IBAction func buttonBack(sender: AnyObject) {
//        
//        //navugate back to previous view
//        self.performSegueWithIdentifier("segueBackToImages2", sender: self);
//        
//    }
    
    @IBOutlet weak var imageScollView: UIScrollView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    
//    Just like the scrolling buttons we just have to make a view, add it to the scroll view and set the content size. Next make an UIImageView in the declaration just below the outlets:
    
   var imageView = UIImageView(image: UIImage(named: "pizza")); //imahe os in image assets and is 70kn 400w x 400h
    
    var currImage: UIImage?
    var textHeading: String?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        Line 1 gets a view. once we have the view we have it’s size which we make the contentSize of the scrollingView. If you skip this step the scroll view will not work. We add the view to the buttonScroll and we are set tot go. The last two lines add a scroll indicator for cosmetic purposes.
        
        
        
        //Image scolling view, voew made dynamically bleow outlets, now add to bootom scrollvoew and set the scroollveiw content size to the imageview we have put in it
        
        println("Scroll Detail view controller")
       // myLabel.text = textHeading
        imageView.image = currImage
        
        
        imageScollView.contentSize = imageView.frame.size;
        imageScollView.addSubview(imageView);
        
        
        //zooming photo, must also overide didLayotSubviews and
        imageSize = imageView.frame.size
        imageScollView.delegate = self
        imageScollView.addSubview(imageView)
        imageScollView.showsHorizontalScrollIndicator = false
        imageScollView.showsVerticalScrollIndicator = false
        

    }
    
    override func viewDidLayoutSubviews() {
        
//        Line 2 sets the maximum zoom scale. I used an arbitrary value of five times the size of the image. I then set the content size. As we’ve already said, the scroll view needs this, but we are keeping the size under control by using a constant, since the content view changes when we rotate the view, and can mess up our calculations. Next we figure the scale by taking the bounds of the scroll View, which by now are correct since auto layout is done with them.
        
        
        imageScollView.maximumZoomScale = 5.0
        imageScollView.contentSize = imageSize
        let widthScale = imageScollView.bounds.size.width / imageSize.width
        let heightScale = imageScollView.bounds.size.height / imageSize.height
        imageScollView.minimumZoomScale = min(widthScale, heightScale)
        imageScollView.setZoomScale(max(widthScale, heightScale), animated: true )
    }
    
    
    //MARK: Delegates
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
//        Our last step is to set up the delegate, which is a quick one. It just wants the view we are zooming to return to the delegate
        
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        
        // hode the staus bar of phone
        
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // navigate back to tab voew controller child view LayoutController so we maintain the views tabs, also pass back the bool to indocate the questuon has already been answered and cannot be asked again
        
        if (segue.identifier == "segueBackToImages2"){
            
            var tabBarC : UITabBarController = segue.destinationViewController as UITabBarController;
            
         // var destionationView: () = tabBarC.selectedIndex = 3;
            
            println(tabBarC);
            
            // 3 = question , 1 = istory, 2 = cored data, 4 = what is diagnosis, 5, 6 , 0 = histor
            var destionationView : LayoutController2 = tabBarC.viewControllers![1] as LayoutController2;
            
            println(tabBarC.viewControllers![1]);
            println(tabBarC.viewControllers![0]);
            
            println("Destionationview : \(destionationView) and view at tabr index 2 \(tabBarC.viewControllers?[1])");
           
            
            for views in tabBarC.viewControllers!{
                
                println("Tabbar voews: \(views) Total Views \(tabBarC.viewControllers?.count))");
            }
            
            // this will occur invidLoad
            //destionationView.questionAnsered = true;
        
        }
//        if(segue.identifier == "ItemDetailsSegue"){
//            
//            //            var tabBarC : UITabBarController = segue.destinationViewController as UITabBarController
//            //            var desView: CaseViewController = tabBarC.viewControllers?.first as CaseViewController
//            //
//            //            var caseIndex = overviewTableView!.indexPathForSelectedRow()!.row
//            //            var selectedCase = self.cases[caseIndex]
//            //
//            //            desView.caseitem = selectedCase
//            
//            
//            var tabBarC : UITabBarController = segue.destinationViewController as UITabBarController;
//            
//            var destinationView : History = tabBarC.viewControllers?.first as History;
//            
//            destinationView.caseNumberSelected = caseNumberToPAsstoHistory;
//            
//            //initilise new vc and cas as history vc
//            
//            //var viewcontroller = segue.destinationViewController as History;
//            
//            // pass the caseNumber we got from didselectRow to Hostory proprty / instance
//            
//            println("Passing case Number to Hisory: \(caseNumberToPAsstoHistory)");
//            
//
//        
//        
//    }
}

}

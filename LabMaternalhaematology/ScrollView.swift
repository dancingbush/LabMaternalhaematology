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

Remeber to set the scrollview delage to the viewcontroller by dragging ot viewcontrolling and - Dlegate (like tableview)


You can simulate the 'pinch to zoom' gesture of the iPhone in Apple's Aspen Simulator by holding down the Option key while clicking the mouse in the area you wish to pinch. This brings up a pair of dots that represent your fingertips.
*/


import UIKit

class ScrollView: UIViewController, UIScrollViewDelegate {

    
    // insances
    
    var imageSize = CGSizeMake(0, 0); // when devoce rotated needed o reset imagescrolvoee content soze
    // view
    
    
    @IBOutlet weak var buttonScrollView: UIScrollView!
    
    
    @IBOutlet weak var imageScollView: UIScrollView!
    
//    Just like the scrolling buttons we just have to make a view, add it to the scroll view and set the content size. Next make an UIImageView in the declaration just below the outlets:
    
    var imageView = UIImageView(image: UIImage(named: "pizza")); //imahe os in image assets and is 70kn 400w x 400h
    
    
    
    func colorButtonsView(buttonSize:CGSize, buttonCount:Int) -> UIView {
        //creates color buttons in a UIView
        let buttonView = UIView()
        
        buttonView.backgroundColor = UIColor.blackColor()
        buttonView.frame.origin = CGPointMake(0,0)
        
        let padding = CGSizeMake(10, 10)
        buttonView.frame.size.width = (buttonSize.width + padding.width) * CGFloat(buttonCount)
        buttonView.frame.size.height = (buttonSize.height +  2.0 * padding.height)

        
        //add buttons to the view
        var buttonPosition = CGPointMake(padding.width * 0.5, padding.height)
        let buttonIncrement = buttonSize.width + padding.width
        let hueIncrement = 1.0 / CGFloat(buttonCount)
        var newHue = hueIncrement
        
        for i in 0...(buttonCount - 1)  {
            var button = UIButton.buttonWithType(.Custom) as UIButton
            button.frame.size = buttonSize
            button.frame.origin = buttonPosition
            buttonPosition.x = buttonPosition.x + buttonIncrement
            button.backgroundColor = UIColor(hue: newHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            newHue = newHue + hueIncrement
            button.addTarget(self, action: "colorButtonPressed:", forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }

        
        return buttonView
    }
    
    
    func colorButtonPressed(sender:UIButton){
        buttonScrollView.backgroundColor = sender.backgroundColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        Line 1 gets a view. once we have the view we have it’s size which we make the contentSize of the scrollingView. If you skip this step the scroll view will not work. We add the view to the buttonScroll and we are set tot go. The last two lines add a scroll indicator for cosmetic purposes.
        
        
        //scrolling pageview
        let scrollingView = colorButtonsView(CGSizeMake(100.0,50.0), buttonCount: 10)
        buttonScrollView.contentSize = scrollingView.frame.size
        buttonScrollView.addSubview(scrollingView)
        buttonScrollView.showsHorizontalScrollIndicator = true
        buttonScrollView.indicatorStyle = .Default
        
        
        //Image scolling view, voew made dynamically bleow outlets, now add to bootom scrollvoew and set the scroollveiw content size to the imageview we have put in it
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

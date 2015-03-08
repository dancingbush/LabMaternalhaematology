//
//  ViewController.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 08/03/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // test parse
        var testObject = PFObject(className: "TestObject2");
        testObject["foo"] = "bar";
        testObject.saveInBackground();

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    


}


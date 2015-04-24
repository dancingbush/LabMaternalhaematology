//
//  iOSVersion.swift
//  LabMaternalhaematology
//
//  Created by Ciaran Mooney on 24/04/2015.
//  Copyright (c) 2015 Ciaran Mooney. All rights reserved.
//

/* A singletn class that allows determination of the IOS version the devce is running on.
Some function wont be supported in iOS 7 ie sime animations and transitions
Use : IOSVersion.SYSTEM_VERSION_LESS_THAN("8.0") retnrs true or false */


import UIKit

class iOSVersion: NSObject {
    
    class func SYSTEM_VERSION_LESS_THAN(version : NSString) -> Bool{
        
        return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending;
    }
   
    class func SYSTEM_VERSION_EQUAL_TO(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version,
            options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
    }
    
    class func SYSTEM_VERSION_GREATER_THAN(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version,
            options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }
    
    class func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version,
            options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
    }
    
    class func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version,
            options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
    }
    
    
}// class

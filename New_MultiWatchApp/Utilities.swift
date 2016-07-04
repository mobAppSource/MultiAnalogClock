//
//  Utilities.swift
//  multiWatchApp
//
//  Created by Master on 6/23/16.
//  Copyright © 2016 Master. All rights reserved.
//

import Foundation
import UIKit

//Displaying the center point in the center of views
func centerPoint(viewBody: UIView)
{
    //center point of each views
    let centerPointView = UIView(frame: CGRect(x: viewBody.frame.size.width/2 - rCenterPoint/2, y: viewBody.frame.size.height/2 - rCenterPoint/2, width: rCenterPoint, height: rCenterPoint))
    centerPointView.backgroundColor = UIColor.yellowColor()
    centerPointView.layer.borderWidth = 1
    centerPointView.layer.borderColor = UIColor.redColor().CGColor
    centerPointView.layer.masksToBounds = true
    centerPointView.layer.cornerRadius = rCenterPoint/2
    viewBody.addSubview(centerPointView)
}


func msgBox(target: AnyObject, title: String, message: String)
{
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
        (sender: UIAlertAction) in
        
    }))
    target.presentViewController(alertController, animated: true, completion: nil)
}

func getTimeFromCityName(city_name: String) -> String
{
    var retString: String!
    let locTime = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "HH:mm"
    
    if let cityTimeZone = NSTimeZone(name: city_name){
        formatter.timeZone = cityTimeZone
        print("\(city_name): \(cityTimeZone)")
    }
    formatter.timeStyle = .ShortStyle
    retString = formatter.stringFromDate(locTime)
    return retString
}
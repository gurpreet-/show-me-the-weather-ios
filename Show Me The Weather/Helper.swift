//
//  Helper.swift
//  Show Me The Weather
//
//  Created by Gurpreet Paul on 15/11/2015.
//  Copyright © 2015 Gurpreet Paul. All rights reserved.
//

import UIKit

/**
 Helper class provides convenience methods.
*/
class Helper {
    
    /// The auth token for the API.
    static let APPID = "0ebb360732e3c553e02742552b1500cf"
    /// The weather API's URL.
    static let BASEURL = "http://api.openweathermap.org/data/2.5/weather"
    
    /**
     Shows an alert
     
     - Parameter title:   The title of the alert.
     - Parameter message: Message of the alert.
     - Parameter controller: The controller, the alert is shown in.
    */
    static func showAlert(title title: String,
                    message: String,
                    controller: UIViewController) {
        let alertController = UIAlertController(title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let action = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil)
        
        alertController.addAction(action)
        controller.presentViewController(alertController,
            animated: true,
            completion: nil)
    }
    
    /**
     Trims the whitespace around text.
     
     - Parameter text:   The text to trim.
     - Returns: Trimmed text.
     */
    static func trim(text: String) -> String {
        return text
            .stringByTrimmingCharactersInSet(NSCharacterSet
                    .whitespaceCharacterSet())
    }
    
}

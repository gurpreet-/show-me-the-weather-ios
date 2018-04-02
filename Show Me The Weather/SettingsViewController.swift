//
//  ViewController.swift
//  Show Me The Weather
//
//  Created by Gurpreet Paul on 14/11/2015.
//  Copyright © 2015 Gurpreet Paul. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextViewDelegate {

    /// OK Button.
    @IBOutlet weak var OKButton: UIButton!
    /// Arrow for the automatic box.
    @IBOutlet weak var arrowAuto: UIImageView!
    /// Arrow for the manual box.
    @IBOutlet weak var arrowManual: UIImageView!
    /// TextView that holds the City.
    @IBOutlet weak var cityTextView: UITextField!
    /// TextView that holds the Country Code.
    @IBOutlet weak var countryCodeTextView: UITextField!
    /// View that holds the Automatic label and arrow.
    @IBOutlet weak var autoBox: UIView!
    
    // Persistent data storage.
    internal let defaults = NSUserDefaults.standardUserDefaults()
    
    /// When the view is loaded, setup everything
    /// in here.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.width, view.frame.height * 2);
        
        // Transform arrow to point down
        arrowManual.transform = CGAffineTransformMakeRotation(1.5708);
        
        // Add a gesture recogniser to the "Automatic" box
        let tapForAuto = UITapGestureRecognizer(target: self,
            action: Selector("automaticBoxTapped:"))
        autoBox.addGestureRecognizer(tapForAuto)
    }
    
    
    /**
     When the automatic box has been tapped.
     
     - Parameter sender: The gesture that called this method.
     */
    func automaticBoxTapped(sender: UITapGestureRecognizer? = nil) {
        defaults.setBool(false, forKey: "isManualLocation")
        tabBarController?.selectedIndex = 0
    }
    
    /**
     When the OK button has been tapped.
     
     - Parameter sender: The UIButton that called this method.
     */
    @IBAction func OKButtonPress(sender: UIButton) {
        // Check if there is text in the TextViews
        let countryHasText = countryCodeTextView.text?.characters.count > 0
        let cityHasText = countryCodeTextView.text?.characters.count > 0
        if countryHasText && cityHasText {
            // ...remove whitespace
            let country:String = Helper.trim(countryCodeTextView.text!)
            let city:String = Helper.trim(cityTextView.text!)
            // Join with comma
            let cityAndCountry = "\(city),\(country)"
            
            // ...update persistent storage
            defaults.setBool(true, forKey: "isManualLocation")
            defaults.setObject(cityAndCountry, forKey: "cityAndCountry")
            
            // ... finally go to main view.
            tabBarController?.selectedIndex = 0
        } else {
            Helper.showAlert(title: "Error",
                message: "Enter city and country.",
                controller: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


//
//  MainViewController.swift
//  Show Me The Weather
//
//  Created by Gurpreet Paul on 15/11/2015.
//  Copyright © 2015 Gurpreet Paul. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import SwiftyJSON

class MainViewController: UIViewController,
                        CLLocationManagerDelegate {
    
    /// Short weather description.
    @IBOutlet var descriptionLabel: UILabel!
    /// The temperature in degrees.
    @IBOutlet var degreesLabel:     UILabel!
    
    /// Location manager to update location.
    internal let locationManager = CLLocationManager()
    /// Stores persistent data.
    internal let defaults        = NSUserDefaults.standardUserDefaults()
    /// API URL to contact.
    internal let URL = "\(Helper.BASEURL)?units=metric"
    
    /// Setup anything in here, but there's nothing
    /// really to setup!
    /// See viewWillAppear() for more info
    /// on how this view is updated.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     Checks if the user has set to use a manual location
     or an auto location. Also 
     makes API requests to update the screen.
     */
    internal func checkAndUpdateScreen() {
        if defaults.boolForKey("isManualLocation") {
            if let city = defaults.objectForKey("cityAndCountry") {
                makeRequest(city as! String)
            }
        } else {
            findLocation()
        }
        
    }
    
    /**
     Starts to find the location of a user, 
     using Location services.
     */
    func findLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    /// Called when the location manager updates its location.
    func locationManager(manager: CLLocationManager,
                        didUpdateLocations locations: [CLLocation]) {
        // Get the first location found
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        
        // Make a request to the API with lat and long
        makeRequest(lat, long:long)
                            
        // Don't forget to stop the location services!
        locationManager.stopUpdatingLocation();
    }
    
    /// Called whenever there's an error in location manager.
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError) {
        print(error)
    }
    
    /**
     Makes a request to an API with the city and the country
     name, e.g. Leeds,GB or Leeds,UK. Also updates the data in view.
     
     - Parameter cityAndCountry:   The city and the country
        delimited by a comma.
     */
    func makeRequest(cityAndCountry: String) {
        // Manually update the URL as commas are a sin
        // in Alamofire apparently
        let finishedURL = "\(URL)&q=\(cityAndCountry)&appid=\(Helper.APPID)"
        Alamofire.request(.GET, finishedURL)
            .responseJSON { reply in self.setLabels(reply) }
    }
    
    /**
     Makes a request to an API with the lat and lon.
     Also updates the data in view.
     
     - Parameter lat:   Latitude of user.
     - Parameter lon:   Longitude of user.
     */
    func makeRequest(lat:Double, long: Double) {
        Alamofire.request(.GET, URL,
            parameters: ["appid": Helper.APPID,
                        "lat": lat,
                        "lon": long])
            .responseJSON { reply in self.setLabels(reply) }
    }
    
    /**
     Sets the data in the view.
     
     - Parameter response: Response of API calls.
     */
    internal func setLabels(response: Response<AnyObject, NSError>) {
        // Convert data to json
        let json = JSON(response.result.value!)
        // Extract relevant fields
        let temp = json["main"]["temp"]
        let description = json["weather"][0]["description"]
        
        // Set the labels
        self.degreesLabel.text! = String(temp)
        self.descriptionLabel.text! = String(description)
    }
    
    /// Update the screen
    override func viewWillAppear(animated: Bool) {
        checkAndUpdateScreen()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

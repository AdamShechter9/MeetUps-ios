//
//  ViewController.swift
//  coreLocationProject
//
//  Created by Adam Shechter on 7/20/16.
//  Copyright © 2016 Adam Shechter. All rights reserved.
//

import UIKit
import CoreLocation



class MyLocationViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    let placemark = CLPlacemark()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBAction func getCurrentLocation(sender: UIButton) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Manager failed with error \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var newLocation = locations
        print(newLocation[0].coordinate.latitude)
        print(newLocation[0].coordinate.longitude)
        latitudeLabel.text = String(newLocation[0].coordinate.latitude)
        longitudeLabel.text = String(newLocation[0].coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(newLocation[0], completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                
                // print(pm.addressDictionary)
                let street = pm.addressDictionary!["Street"]
                let city = pm.addressDictionary!["City"]
                let state = pm.addressDictionary!["State"]
                let zip = pm.addressDictionary!["ZIP"]
                print("\(street!), \(city!), \(state!), \(zip!)")
                self.addressLabel.text = "\(street!), \(city!), \(state!), \(zip!)"
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 1
        locationManager.delegate = self
        // 2
        locationManager.requestAlwaysAuthorization()
        print("in MyLocation")
    }

    

}


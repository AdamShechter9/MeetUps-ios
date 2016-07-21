//
//  MyMapViewController.swift
//  coreLocationProject
//
//  Created by Adam Shechter on 7/20/16.
//  Copyright © 2016 Adam Shechter. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MyMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, CancelButtonDelegate, AddMeetUpButtonDelegate
{
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    let placemark = CLPlacemark()
    var tempCoord = CLLocationCoordinate2D()
    
    var latitudeDelta = 1.0
    var longitudeDelta = 1.0
    var PinsAnnotationArr = [MKPointAnnotation]()
    var locationsArr = [
        ["latitude": "37.377034", "longitude": "-121.912302", "title": "Coding Dojo", "subtitle": "Coding Hackathon Party"],
        ["latitude": "37.421385", "longitude": "-122.088882", "title": "GooglePlex", "subtitle": "Google Coding Party"],
        ["latitude": "37.422799", "longitude": "-122.070514", "title": "LinkedIn", "subtitle": "LinkedIn Networking Party"]
    ]
    
    var dummylocation1Flag = false
    var zoomFirstFlag = true
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var dummyLocation1: UIBarButtonItem!
    @IBAction func dummyLocation1Pressed(sender: UIBarButtonItem) {

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print ("yo")
        if segue.identifier == "addMeetupSegue"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let addPinViewController = navigationController.topViewController as! AddMeetupViewController
            addPinViewController.cancelButtonDelegate = self
            addPinViewController.addMeetUpButtonDelegate = self
        }
    }
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func addMeetUpButtonPressedFrom(controller: UIViewController, meetup: [String:String]) {
        print(meetup["address"])
        geocoder.geocodeAddressString(meetup["address"]!)
        {
            (placemarks, error) -> Void in
            
            if let firstPlacemark = placemarks?[0] {
                print("decoding address")
                let latitude = firstPlacemark.location?.coordinate.latitude
                let longitude = firstPlacemark.location?.coordinate.longitude
                self.tempCoord = (firstPlacemark.location?.coordinate)!
            }
            let latitude = self.tempCoord.latitude
            let longitude = self.tempCoord.longitude
            let title = String(meetup["title"]!)
            let subtitle = String(meetup["subtitle"]!)
            // locationsArr.append(meetup)
            print("meetup \(meetup)")
            print("latitude \(latitude)    longitude \(longitude)       title \(title)      subtitle  \(subtitle)")
            self.addPinsToMap(latitude, longitude: longitude, title: title, subtitle: subtitle)
        }
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    @IBAction func zoomIn(sender: UIBarButtonItem) {
        latitudeDelta *= 0.1
        longitudeDelta *= 0.1
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000 * latitudeDelta, 2000 * longitudeDelta)
        
        mapView.setRegion(region, animated: true)
    }
    @IBAction func zoomOut(sender: UIBarButtonItem) {
        latitudeDelta *= 10
        longitudeDelta *= 10

        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000 * latitudeDelta, 2000 * longitudeDelta)
        
        mapView.setRegion(region, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in MyMaps")
        mapView.delegate = self 
        mapView.showsUserLocation = true
        let userLocation = mapView.userLocation
        print(userLocation)
         
        // 1
        locationManager.delegate = self
        // 2
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        for location in locationsArr
        {
            let latitude = Double(location["latitude"]!)
            let longitude = Double(location["longitude"]!)
            let title = String(location["title"]!)
            let subtitle = String(location["subtitle"]!)
            addPinsToMap(latitude!, longitude: longitude!, title: title, subtitle: subtitle)
        }
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Manager failed with error \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var newLocation = locations
        print(newLocation[0].coordinate.latitude)
        print(newLocation[0].coordinate.longitude)
        // latitudeLabel.text = String(newLocation[0].coordinate.latitude)
        // longitudeLabel.text = String(newLocation[0].coordinate.longitude)
        
        
        
        geocoder.reverseGeocodeLocation(newLocation[0], completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                
                // print(pm.addressDictionary)
                // let street = pm.addressDictionary!["Street"]
                // let city = pm.addressDictionary!["City"]
                // let state = pm.addressDictionary!["State"]
                // let zip = pm.addressDictionary!["ZIP"]
                // print("\(street!), \(city!), \(state!), \(zip!)")
                // self.addressLabel.text = "\(street!), \(city!), \(state!), \(zip!)"
                if self.zoomFirstFlag
                {
                    let userLocation = self.mapView.userLocation
                    if userLocation.location != nil
                    {
                        let region = MKCoordinateRegionMakeWithDistance(
                            userLocation.location!.coordinate, 20000, 20000)
                        
                        self.mapView.setRegion(region, animated: true)
                        self.zoomFirstFlag = false
                    }
                }
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func showAnnotationPoints()
    {

    }
    
    func addPinsToMap(latitude: Double, longitude: Double, title: String, subtitle: String)
    {
        print("in addPinsToMap")
        print("latitude \(latitude)    longitude \(longitude)    title \(title)        subtitle  \(subtitle)")
        var annotationCoord = CLLocationCoordinate2D()
        var annotationPoint = MKPointAnnotation()

        annotationCoord.latitude = latitude
        annotationCoord.longitude = longitude
        annotationPoint.coordinate = annotationCoord
        annotationPoint.title = title
        annotationPoint.subtitle = subtitle
        mapView.addAnnotation(annotationPoint)
        PinsAnnotationArr.append(annotationPoint)
        print("PinsAnnotationArr")
    }
}

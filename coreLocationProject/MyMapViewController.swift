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

class MyMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    let placemark = CLPlacemark()
    
    var latitudeDelta = 1.0
    var longitudeDelta = 1.0
    var PinsAnnotationArr = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func zoomIn(sender: UIBarButtonItem) {
        latitudeDelta *= 0.1
        longitudeDelta *= 0.1
    }
    @IBAction func zoomOut(sender: UIBarButtonItem) {
        latitudeDelta *= 10
        longitudeDelta *= 10

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
        var annotationPoint = MKPointAnnotation()
        

        // annotationPoint.coordinate = annotationCoord
        // annotationPoint.coordinate.latitude = 37.377034
        // annotationPoint.coordinate.longitude = -121.912302
        // annotationPoint.title = "Coding Dojo"
        // annotationPoint.subtitle = "Meetup Right now"
        annotationPoint.coordinate.latitude = latitude
        annotationPoint.coordinate.latitude = longitude
        annotationPoint.title = title
        annotationPoint.subtitle = subtitle
        mapView.addAnnotation(annotationPoint)
    }
}

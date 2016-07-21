//
//  locationDelegateClass.swift
//  coreLocationProject
//
//  Created by Adam Shechter on 7/20/16.
//  Copyright © 2016 Adam Shechter. All rights reserved.
//

import Foundation
import CoreLocation

class locationDelegateClass
{
    var locationDelegate = CLLocation()
    
    
    func saveLocationDelegate (updateLocation location: [CLLocation])
    {
        locationDelegate = location[0]
        print("in locationDelegateClass updating")
    }
}
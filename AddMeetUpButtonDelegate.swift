//
//  AddMeetUpButtonDelegate.swift
//  coreLocationProject
//
//  Created by JD Penuliar on 7/21/16.
//  Copyright © 2016 Adam Shechter. All rights reserved.
//

import UIKit
protocol AddMeetUpButtonDelegate: class {
    func addMeetUpButtonPressedFrom(controller: UIViewController, meetup:[String:String])
}

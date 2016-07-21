//
//  AddMeetupViewController.swift
//  coreLocationProject
//
//  Created by Adam Shechter on 7/21/16.
//  Copyright © 2016 Adam Shechter. All rights reserved.
//

import UIKit

class AddMeetupViewController: UIViewController
{
    
    // inputs
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var subTitleLabel: UITextField!
    @IBOutlet weak var latitudeLabel: UITextField!
    @IBOutlet weak var longitudeLabel: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var meetup = [String:String]()
    
    var cancelButtonDelegate: CancelButtonDelegate?
    var addMeetUpButtonDelegate: AddMeetUpButtonDelegate?
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    @IBAction func addMeetUpPressed(sender: AnyObject) {
        meetup["title"] = titleLabel.text!
        meetup["subtitle"] = subTitleLabel.text!
        meetup["address"] = addressTextField.text!
        addMeetUpButtonDelegate?.addMeetUpButtonPressedFrom(self, meetup: meetup)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in add meetup view controller")
    }
}

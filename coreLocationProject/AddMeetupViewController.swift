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
    var cancelButtonDelegate: CancelButtonDelegate?
    var addMeetUpButtonDelegate: AddMeetUpButtonDelegate?
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    @IBAction func addMeetUpPressed(sender: AnyObject) {
        addMeetUpButtonDelegate?.addMeetUpButtonPressedFrom(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in add meetup view controller")
    }
}

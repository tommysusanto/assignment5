//
//  PushReminderViewController.swift
//  Reminders
//
//  Created by Tommy Susanto on 4/05/2016.
//  Copyright © 2016 HB. All rights reserved.
//

import Foundation
import UIKit

protocol PushReminderViewControllerDelegate {
    func passDataPushView(result: [String],title: [String],radio: [Bool])
}

class PushReminderViewController: UIViewController, ReminderViewControllerDelegate {
    
    var delegate: PushReminderViewControllerDelegate? = nil
    var mainDescription: [String] = []
    var titleArray: [String] = []
    var radioButton: [Bool] = []
    var selectedTitle: String?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="sbPushSegue"{
            let reminderVC: ReminderViewController = segue.destinationViewController as! ReminderViewController
            reminderVC.descriptionArray = self.mainDescription
            reminderVC.selectedTitle=self.selectedTitle
            reminderVC.titleText = self.titleArray
            reminderVC.radioButtonArray = self.radioButton
            reminderVC.numberOfRows=self.mainDescription.count
            reminderVC.delegate = self
        }
    }
    
    // Delegates
    func passData(content: [String], title: [String],radio: [Bool]) {
        mainDescription = content
        titleArray = title
        radioButton = radio
        delegate?.passDataPushView(mainDescription,title: titleArray,radio: radioButton)
    }
}


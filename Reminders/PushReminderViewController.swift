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
    func passDataPushView(result: [String],title: String)
}

class PushReminderViewController: UIViewController, ReminderViewControllerDelegate {
    
    var delegate: PushReminderViewControllerDelegate? = nil
    var descriptionPushView: [String] = []
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="sbPushSegue"{
            let reminderVC: ReminderViewController = segue.destinationViewController as! ReminderViewController
            reminderVC.delegate = self
        }
    }
    
    func passData(content: [String], title: String) {
        descriptionPushView = content
        delegate?.passDataPushView(descriptionPushView,title: title)
    }
}


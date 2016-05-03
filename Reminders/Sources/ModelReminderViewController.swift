//  Copyright © 2016 HB. All rights reserved.

protocol ModalReminderViewControllerDelegate {
    func passDataModalView(result: [String],title: String)
}

class ModalReminderViewController: UIViewController, ReminderViewControllerDelegate {
    
    var delegate: ModalReminderViewControllerDelegate? = nil
    var descriptionModalView: [String] = []

  @IBAction func addButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="sbSegueModal"{
            let reminderVC: ReminderViewController = segue.destinationViewController as! ReminderViewController
            reminderVC.delegate = self
        }
    }
    
    func passData(content: [String],title: String) {
        descriptionModalView = content
        delegate?.passDataModalView(descriptionModalView,title: title)
    }
}

import UIKit

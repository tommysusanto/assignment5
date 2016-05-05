//  Copyright © 2016 HB. All rights reserved.

class TaskTableViewCell: UITableViewCell {

  var completed = false

    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var buttonImage: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if completed == false {
            buttonImage.setImage(UIImage(named:"radio-off"), forState: .Normal)
        }
        else{
             buttonImage.setImage(UIImage(named:"radio-on"), forState: .Normal)
        }
    }
    
  @IBAction func radioButtonPressed(sender: AnyObject) {
    if let button = sender as? UIButton {
      button.setImage(
        UIImage(named: completed ? "radio-off" : "radio-on"),
        forState: .Normal)
      completed = !completed
    }
  }
}

import UIKit

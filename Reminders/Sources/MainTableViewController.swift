//  Copyright © 2016 HB. All rights reserved.

class MainTableViewController: UITableViewController, ModalReminderViewControllerDelegate {

  let menuTableViewCellId = "MenuTableViewCell"
  let addTableViewCellId = "AddReminderTableViewCell"
  let reminderViewControllerId = "ReminderViewController"
    var mainDescription: [String] = []
    var mainTitle: [String] = []
    var numberOfRows = 0

    @IBOutlet var mainTableView: UITableView!
    
    override func viewDidLoad() {
        mainTableView.delegate=self
        mainTableView.dataSource=self
    }
    
  override func tableView(
    tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      return numberOfRows+1
  }

  override func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell: UITableViewCell?

      switch indexPath.row {
      case 0 where numberOfRows == 0, numberOfRows:
        cell = tableView.dequeueReusableCellWithIdentifier(addTableViewCellId)
      default:
        cell = tableView.dequeueReusableCellWithIdentifier(menuTableViewCellId)
        
        if let cell = cell {
            cell.textLabel?.text = mainTitle[indexPath.row]
            cell.detailTextLabel?.text = mainDescription[indexPath.row]
        }
      }
      return cell!
  }
    
  override func tableView(
    tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="modalSegue"{
            let modalView: ModalReminderViewController = segue.destinationViewController as! ModalReminderViewController
            modalView.delegate = self
        }
    }
    
    func passDataModalView(result: [String],title: String) {
        for element in result {
            mainDescription.append(element)
            mainTitle.append(title)
        }
        numberOfRows=mainDescription.count
        mainTableView.reloadData()
    }

}

import UIKit

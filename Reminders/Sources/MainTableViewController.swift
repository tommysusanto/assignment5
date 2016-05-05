//  Copyright © 2016 HB. All rights reserved.
class MainTableViewController: UITableViewController, ModalReminderViewControllerDelegate,PushReminderViewControllerDelegate {

  let menuTableViewCellId = "MenuTableViewCell"
  let addTableViewCellId = "AddReminderTableViewCell"
  let reminderViewControllerId = "ReminderViewController"
    var mainDescription: [String] = []
    var mainTitle: [String] = []
    var radioButton: [Bool] = []
    var selectedRow: Int?
    var selectedTitle: String?
    
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
    selectedRow = indexPath.row
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="modalSegue"{
            let modalView: ModalReminderViewController = segue.destinationViewController as! ModalReminderViewController
            modalView.delegate = self
        }
        else if segue.identifier=="pushSegue"{
            let pushView: PushReminderViewController = segue.destinationViewController as! PushReminderViewController
            var tempDescription: [String] = []
            var tempTitle: [String] = []
            var tempButton: [Bool] = []
            let correctTitle:String = mainTitle[selectedRow!]
            for index in 0..<mainDescription.count{
                if mainTitle[index] == correctTitle{
                    tempDescription.append(mainDescription[index])
                    tempTitle.append(mainTitle[index])
                    tempButton.append(radioButton[index])
                }
            }
            pushView.selectedTitle = tempTitle[0]
            pushView.mainDescription = tempDescription
            pushView.titleArray = tempTitle
            pushView.radioButton=tempButton
            pushView.delegate = self
        }
        
    }
    
    // External Delegates
    func passDataPushView(result: [String], title: [String], radio: [Bool]) {
        for index in 0..<title.count {
            for index2 in 0..<mainTitle.count{
                if title[index]==mainTitle[index2]{
                    mainTitle[index2]=title[index2]
                    mainDescription[index2]=result[index2]
                    radioButton[index2]=radio[index2]
                }
            }
        }
        numberOfRows=mainDescription.count
        mainTableView.reloadData()
    }
    
    func passDataModalView(result: [String],title: [String],radio: [Bool]) {
        for index in 0..<result.count {
            mainDescription.append(result[index])
            mainTitle.append(title[index])
            radioButton.append(radio[index])
        }
        numberOfRows=mainDescription.count
        mainTableView.reloadData()
    }
    /*
    func mainTableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func mainTableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            mainDescription.removeAtIndex(indexPath.row)
            mainTitle.removeAtIndex(indexPath.row)

            mainTableView.reloadData()
        }
    }*/

}

import UIKit

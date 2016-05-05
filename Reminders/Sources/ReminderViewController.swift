//  Copyright © 2016 HB. All rights reserved.
protocol ReminderViewControllerDelegate
{
    func passData(content: [String],title: [String],radio: [Bool])
}

class ReminderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tasksTableView: UITableView!
  @IBOutlet weak var titleTextField: UITextField!

  let taskTableViewCellIdentifier = "TaskTableViewCell"
  let addTaskTableViewCellIdentifier = "AddTaskTableViewCell"
    var delegate: ReminderViewControllerDelegate?
    
    var reminder: [Reminder] = []
    
    var descriptionArray: [String] = []
    var titleText: [String] = []
    var radioButtonArray: [Bool] = []
    var selectedTitle: String?

  var numberOfRows = 0

  // MARK: ViewController Lifecycle

  override func viewDidAppear(animated: Bool) {
    tasksTableView.delegate = self
    tasksTableView.dataSource = self
    titleTextField.text=selectedTitle
    tasksTableView.reloadData()
  }

  // Mark: TableView Delegate and DataSource

  func tableView(
    tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      return numberOfRows + 1
  }

  func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell: UITableViewCell?

      switch indexPath.row {
      case 0 where numberOfRows == 0, numberOfRows:
        cell = tableView.dequeueReusableCellWithIdentifier(addTaskTableViewCellIdentifier)
        
      default:
        cell = tableView.dequeueReusableCellWithIdentifier(taskTableViewCellIdentifier)
        let cell = cell as? TaskTableViewCell
        let isIndexValid = descriptionArray.indices.contains(indexPath.row)
        if isIndexValid == true{
            cell?.txtDescription.text = descriptionArray[indexPath.row]
            cell?.completed = radioButtonArray[indexPath.row]
        }
      }

      return cell!
  }

  func tableView(
    tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath) {
      switch indexPath.row {
      case 0 where numberOfRows == 0, numberOfRows:
        numberOfRows += 1
        tableView.reloadData()
      default:
        break
      }

      tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
    
    override func viewDidDisappear(animated: Bool) {
        //let cells = tasksTableView.visibleCells as! Array<TaskTableViewCell>
        
        for cell in tasksTableView.visibleCells {
            if let cellTemp = cell as? TaskTableViewCell{
                var doesExists: Bool = false
                for index1 in 0..<titleText.count{
                    if titleText [index1] == titleTextField.text!{
                        for index2 in 0..<descriptionArray.count{
                            if descriptionArray[index2]==cellTemp.txtDescription.text!{
                                doesExists = true
                            }
                        }
                    }
                }
                if doesExists == false {
                    descriptionArray.append(cellTemp.txtDescription.text!)
                    titleText.append(titleTextField.text!)
                    radioButtonArray.append(cellTemp.completed)
                }
            }
        }
        if titleText.count != 0 && descriptionArray.count != 0 {
            delegate?.passData(descriptionArray,title: titleText,radio: radioButtonArray)
        }
    }
}

import UIKit

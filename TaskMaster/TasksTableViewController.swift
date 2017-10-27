//
//  TasksTableViewController.swift
//  Pomodoro
//
//  Created by Karen Brown on 23/09/17.
//  Copyright © 2017 TWL Software. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var managedObjectContext: NSManagedObjectContext? = nil
    
    var taskList = ["+"]
    
    @IBAction func addTask(_ sender: Any) {
    //add a task to the list
        
        //call a modal view with a text field + save and cancel buttons
        let alert = UIAlertController(title: "New Task",
                                      message: "Add a task",
                                      preferredStyle: .alert)
        
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let taskToSave = textField.text else {
                                                return
                                        }
                                        
                                        //call the save function
                                        self.save(description: taskToSave)
                                        
                                        self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert,animated: true)
        
    }
    
    //save new task
    func save(description: String) {
        
        // save task
        /*
        task.setValue(description, forKeyPath: "taskDescription")
        task.setValue(NSDate(), forKey: "dateAdded")
        task.setValue(false, forKey: "doneIndicator")
 */
        
    }
        

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // delete row
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view

    override func numberOfSections(in tableView: UITableView) -> Int {
        //TODO: return number of sections
        return 1
    }

    //completed status to be header of section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return nil
    }
    //return the number of rows grouped by completed or not completed
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TDO: return correct number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = "test"

        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

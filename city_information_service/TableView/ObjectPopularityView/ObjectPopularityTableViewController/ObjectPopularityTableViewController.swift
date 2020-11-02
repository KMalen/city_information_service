//
//  ObjectPopularityTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/30/20.
//

import UIKit

class ObjectPopularityTableViewController: UITableViewController {

    var dbObjectPopularity: ObjectPopularityController = ObjectPopularityController()
    var objectPopularity: [ObjectPopularity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Object Popularity Table"
        
        objectPopularity = dbObjectPopularity.read()
        
    }
    
    @IBAction func unwindSegueWithSegueToObjectPopularity(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else { return }
        
        let sourveVC = segue.source as! NewObjectPopularityTableViewController
        let object = sourveVC.object
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            objectPopularity[selectedIndexPath.row] = object
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            
            dbObjectPopularity.deleteByID(id: object.objectPopularityID)
            dbObjectPopularity.insert(id: object.objectPopularityID, nameObject: object.objectName, visitDate: object.visitDate, visits: object.visits)
            
        } else {
            
            let newIndexPath = IndexPath(row: objectPopularity.count, section: 0)
            
            objectPopularity.append(object)
            tableView.insertRows(at: [newIndexPath], with: .fade)
            dbObjectPopularity.insert(id: object.objectPopularityID, nameObject: object.objectName, visitDate: object.visitDate, visits: object.visits)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "addSegue" {
            
            let navVCForAdd = segue.destination as! UINavigationController
            let newID = navVCForAdd.topViewController as! NewObjectPopularityTableViewController
            
            newID.lastPopularity = objectPopularity.count
        }
        
        else {
            
            guard segue.identifier == "editPopularityObject" else { return }
            
            let indexPath = tableView.indexPathForSelectedRow!
            let objPop = objectPopularity[indexPath.row]
            
            let navigationVC = segue.destination as! UINavigationController
            let newObjetPopularityVC = navigationVC.topViewController as! NewObjectPopularityTableViewController
            
            newObjetPopularityVC.object = objPop
            newObjetPopularityVC.lastPopularity = objPop.objectPopularityID
            newObjetPopularityVC.title = "Edit"
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectPopularity.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectPopularityCell", for: indexPath) as! ObjectPopularityTableViewCell
        
        let answerCell:String = String(objectPopularity[indexPath.row].objectPopularityID) + " " + objectPopularity[indexPath.row].objectName + " "
        
        cell.textObjectPopularityLabel?.text = answerCell + " " + objectPopularity[indexPath.row].visitDate + " " +  String(objectPopularity[indexPath.row].visits)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dbObjectPopularity.deleteByID(id: objectPopularity[indexPath.row].objectPopularityID)
            objectPopularity.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

//
//  RequestsTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/2/20.
//

import UIKit

class RequestsTableViewController: UITableViewController {
    
    var dbRequests: RequestsController = RequestsController()
    var requests: [Requests] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Requests Table"
        
        requests = dbRequests.read()
        
    }
    
    @IBAction func unwindSegueWithSegueToRequests(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else { return }
        
        let sourveVC = segue.source as! NewRequestsTableViewController
        let object = sourveVC.object
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            requests[selectedIndexPath.row] = object
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            
            dbRequests.deleteByID(id: object.requestID)
            dbRequests.insert(id: object.requestID, nameObject: object.objectName, eventDate: object.eventDate, eventName: object.eventName, eventType: object.eventType, address: object.address)
            
        } else {
            
            let newIndexPath = IndexPath(row: requests.count, section: 0)
            
            requests.append(object)
            tableView.insertRows(at: [newIndexPath], with: .fade)
            dbRequests.insert(id: object.requestID, nameObject: object.objectName, eventDate: object.eventDate, eventName: object.eventName, eventType: object.eventType, address: object.address)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "addSegue" {
            
            let navVCForAdd = segue.destination as! UINavigationController
            let newID = navVCForAdd.topViewController as! NewRequestsTableViewController
            
            newID.lastRequest = requests.count
        }
        
        else {
            
            guard segue.identifier == "editRequests" else { return }
            
            let indexPath = tableView.indexPathForSelectedRow!
            let req = requests[indexPath.row]
            
            let navigationVC = segue.destination as! UINavigationController
            let newReqVC = navigationVC.topViewController as! NewRequestsTableViewController
            
            newReqVC.object = req
            newReqVC.lastRequest = req.requestID
            newReqVC.title = "Edit"
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requests.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestsTableViewCell", for: indexPath) as! RequestsTableViewCell

        // Configure the cell...

        let answerCell:String = String(requests[indexPath.row].requestID) + " " + requests[indexPath.row].objectName + " " + requests[indexPath.row].eventDate + " " + requests[indexPath.row].eventName
        cell.textRequestsLabel?.text = answerCell + " " + requests[indexPath.row].eventType + " " + requests[indexPath.row].address
        
        return cell
    }


    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dbRequests.deleteByID(id: requests[indexPath.row].requestID)
            requests.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

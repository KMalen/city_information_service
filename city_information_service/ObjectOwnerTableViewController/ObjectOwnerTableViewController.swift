//
//  ObjectOwnerTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/28/20.
//

import UIKit

class ObjectOwnerTableViewController: UITableViewController {
    
    var dbObjectOwner: ObjectOwnerController = ObjectOwnerController()
    var objectOwner:[ObjectOwner] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Object Owner Table"
        
        objectOwner = dbObjectOwner.read()
    }
    
    @IBAction func unwidSegueWithSegueToObjectOwner(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        
        let sourceVC = segue.source as! NewObjectOwnerTableViewController
        let object = sourceVC.object
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            objectOwner[selectedIndexPath.row] = object
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            
            dbObjectOwner.deleteByID(id: object.ownerID)
            dbObjectOwner.insert(id: object.ownerID, nameObject: object.objectName, ownerName: object.ownerName, ownerType: object.ownerType, ownerPhone: object.ownerPhone, openingDate: object.openingDate)
            
        } else {
            
            let newIndexPath = IndexPath(row: objectOwner.count, section: 0)
            
            objectOwner.append(object)
            tableView.insertRows(at: [newIndexPath], with: .fade)
            dbObjectOwner.insert(id: object.ownerID, nameObject: object.objectName, ownerName: object.ownerName, ownerType: object.ownerType, ownerPhone: object.ownerPhone, openingDate: object.openingDate)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "addSegue" {
            
            let destination = segue.destination as? NewObjectOwnerTableViewController
            destination?.lastOwnerID = objectOwner.count
            
        } else {
        
        guard segue.identifier == "editObjectOwner" else { return }
        
        let indexPath = tableView.indexPathForSelectedRow!
        let objOwner = objectOwner[indexPath.row]
        
        let navigationVC = segue.destination as! UINavigationController
        let newObjectOwnerVC = navigationVC.topViewController as! NewObjectOwnerTableViewController
        
        //dbObjectOwner.deleteByID(id: objOwner.ownerID)
        
        newObjectOwnerVC.object = objOwner
        newObjectOwnerVC.title = "Edit"
    }
}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectOwner.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectOwnerCell", for: indexPath) as! ObjectOwnerTableViewCell
        
        
        let answerCell:String = String(objectOwner[indexPath.row].ownerID) + " " + objectOwner[indexPath.row].objectName + " " + objectOwner[indexPath.row].ownerName + " "

        cell.textOwnerObjectLabel?.text = answerCell + objectOwner[indexPath.row].ownerType + " " + objectOwner[indexPath.row].ownerPhone + " " + objectOwner[indexPath.row].openingDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dbObjectOwner.deleteByID(id: objectOwner[indexPath.row].ownerID)
            objectOwner.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

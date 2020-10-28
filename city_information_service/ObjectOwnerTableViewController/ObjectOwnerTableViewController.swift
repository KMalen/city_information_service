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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectOwner.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectOwnerCell", for: indexPath) as! ObjectOwnerTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let answerCell:String = String(objectOwner[indexPath.row].ownerID) + " " + objectOwner[indexPath.row].objectName + " " + objectOwner[indexPath.row].ownerName + " "

        cell.textOwnerObjectLabel?.text = answerCell + objectOwner[indexPath.row].ownerType + " " + objectOwner[indexPath.row].ownerPhone + " " + dateFormatter.string(from: objectOwner[indexPath.row].openingDate)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

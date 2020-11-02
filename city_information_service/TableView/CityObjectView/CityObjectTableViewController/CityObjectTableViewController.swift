//
//  CityObjectTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/21/20.
//

import UIKit

class CityObjectTableViewController: UITableViewController {
    
    var dbCityObject: ObjectCityController = ObjectCityController()
    var cityObject:[CityObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "City Object Table"
        
        cityObject = dbCityObject.read()
        print(dbCityObject.DBHelp.path)
        
    }
    
    @IBAction func unwindSegueWithSegueToCityObject(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        
        let sourceVC = segue.source as! NewObjectCityTableViewController
        let object = sourceVC.object
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            cityObject[selectedIndexPath.row] = object
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            
            dbCityObject.deleteByName(name: object.objectName)
            dbCityObject.insert(name: object.objectName, type: object.typeObject, adress: object.adressObject, places: object.placesInObject, owner: object.ownerObject, seasonality: object.seasonalityObject)
            
        } else {
            
            let newIndexPath = IndexPath(row: cityObject.count, section: 0)
            cityObject.append(object)
            tableView.insertRows(at: [newIndexPath], with: .fade)
            dbCityObject.insert(name: object.objectName, type: object.typeObject, adress: object.adressObject, places: object.placesInObject, owner: object.ownerObject, seasonality: object.seasonalityObject)
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editCityObject" else { return }
        
        let indexPath = tableView.indexPathForSelectedRow!
        let cityObj = cityObject[indexPath.row]
        
        let navigationVC = segue.destination as! UINavigationController
        let newCityObjectVC = navigationVC.topViewController as! NewObjectCityTableViewController
        
        newCityObjectVC.object = cityObj
        newCityObjectVC.title = "Edit"
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityObject.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityObjectCell", for: indexPath) as! CityObjectTableViewCell
        // Configure the cell...

        cell.textObjectLabel?.text = cityObject[indexPath.row].objectName + " " + cityObject[indexPath.row].typeObject + " " + cityObject[indexPath.row].adressObject + " " + String(cityObject[indexPath.row].placesInObject) + " " + cityObject[indexPath.row].ownerObject + " " + cityObject[indexPath.row].seasonalityObject
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dbCityObject.deleteByName(name: cityObject[indexPath.row].objectName)
            cityObject.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

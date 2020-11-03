//
//  SecondRequestTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/3/20.
//

import UIKit

class SecondRequestTableViewController: UITableViewController {
    
    var dbSecondRequest: SecondRequestController = SecondRequestController()
    var secondRequestAnswer: [SecondRequest] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Second Request"
        secondRequestAnswer = dbSecondRequest.read()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return secondRequestAnswer.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondRequestLabel", for: indexPath) as! SecondRequestTableViewCell

        // Configure the cell...
        
        let answerCell = secondRequestAnswer[indexPath.row].nameObject + " " + secondRequestAnswer[indexPath.row].eventName + " " + secondRequestAnswer[indexPath.row].eventDate + " "
        
        cell.SecondRequestLabel?.text = answerCell + " " + secondRequestAnswer[indexPath.row].address

        return cell
    }

}

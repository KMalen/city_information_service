//
//  FirstRequestViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/2/20.
//

import UIKit

class FirstRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dbFirstRequest: FirstRequestController = FirstRequestController()
    var firstRequestAnsw: [FirstRequest] = []
    
    @IBOutlet weak var firstRequestTableView: UITableView!
    @IBOutlet weak var searchDateDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        self.title = "First Request"
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        self.firstRequestAnsw = dbFirstRequest.read(dateFromUser: dateFormatter.string(from: searchDateDatePicker.date))
        firstRequestTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstRequestAnsw.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstRequestLabel", for: indexPath) as! FirstRequestTableViewCell
        
        cell.FirstRequestLabel?.text = firstRequestAnsw[indexPath.row].addressObject + " " + firstRequestAnsw[indexPath.row].nameObject + " " + firstRequestAnsw[indexPath.row].typeObject
        
        return cell
    }

}

//
//  ThirdRequestViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/3/20.
//

import UIKit

class ThirdRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dbThirdRequest: ThirdRequestController = ThirdRequestController()
    var thirdRequestAnsw: [ThirdRequest] = []
    
    
    @IBOutlet weak var thirdRequestTableView: UITableView!
    @IBOutlet weak var typeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Third Request"

    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        self.thirdRequestAnsw = dbThirdRequest.read(typeFromUser: typeTextField.text ?? "")
        thirdRequestTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thirdRequestAnsw.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdRequestLabel", for: indexPath) as! ThirdRequestTableViewCell
        
        let answerCell = thirdRequestAnsw[indexPath.row].objectName + " " + thirdRequestAnsw[indexPath.row].typeObject + " " + thirdRequestAnsw[indexPath.row].addressObject + " "
        
        let answerCell2 = String(thirdRequestAnsw[indexPath.row].placesInObject) + " " + thirdRequestAnsw[indexPath.row].ownerObject + " " + thirdRequestAnsw[indexPath.row].seasonalityObject
        
        cell.ThirdRequestLabel?.text = answerCell + answerCell2
        
        return cell
    }

}

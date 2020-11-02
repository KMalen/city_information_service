//
//  NewObjectPopularityTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/1/20.
//

import UIKit

class NewObjectPopularityTableViewController: UITableViewController {
    
    var object = ObjectPopularity(objectPopularityID: 0, objectName: "", visitDate: "", visits: 0)

    @IBOutlet weak var nameObjectextField: UITextField!
    @IBOutlet weak var visitDateDatePicker: UIDatePicker!
    @IBOutlet weak var visitsTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var lastPopularityID: Int = 0
    var lastPopularity: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateSaveButtonState()
    }
    
    public func updateSaveButtonState(){
        
        let objectNameText = nameObjectextField.text ?? ""
        let visitsText = Int(visitsTextField.text ?? String(0))
        
        saveButton.isEnabled = !objectNameText.isEmpty && visitsText ?? 0 > 0
        
    }
    
    private func updateUI(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        lastPopularityID = lastPopularity
        
        nameObjectextField.text = object.objectName
        visitDateDatePicker.date = dateFormatter.date(from: object.visitDate) ?? Date()
        visitsTextField.text = String(object.visits)
    }

    @IBAction func textChanged(_ sender: UITextField){
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let objectNameText = nameObjectextField.text ?? ""
        let visitsText = Int(visitsTextField.text ?? String(0))
        let visitDateText = dateFormatter.string(from: visitDateDatePicker.date)
        
        self.object = ObjectPopularity(objectPopularityID: lastPopularityID, objectName: objectNameText, visitDate: visitDateText, visits: Int(visitsText!))
        
    }
}

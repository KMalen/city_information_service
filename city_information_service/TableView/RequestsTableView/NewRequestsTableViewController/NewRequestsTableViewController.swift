//
//  NewRequestsTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/2/20.
//

import UIKit

class NewRequestsTableViewController: UITableViewController {
    
    var lastRequest: Int = 0
    var lastRequestID: Int = 0
    
    var object: Requests = Requests(requestID: 0, objectName: "", eventDate: "", eventName: "", eventType: "", address: "")
    
    @IBOutlet weak var nameObjectTextField: UITextField!
    @IBOutlet weak var evenDateDatePicker: UIDatePicker!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        
        let objectNameText = nameObjectTextField.text ?? ""
        let eventNameText = eventNameTextField.text ?? ""
        let eventTypeText = eventTypeTextField.text ?? ""
        let addressText = addressTextField.text ?? ""
        
        saveButton.isEnabled = !objectNameText.isEmpty && !eventNameText.isEmpty && !eventTypeText.isEmpty && !addressText.isEmpty
    }
    
    private func updateUI(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        lastRequestID = lastRequest
        
        nameObjectTextField.text = object.objectName
        evenDateDatePicker.date = dateFormatter.date(from: object.eventDate) ?? Date()
        eventNameTextField.text = object.eventName
        eventTypeTextField.text = object.eventType
        addressTextField.text = object.address
    }
    
    @IBAction func textChanged() {
        updateSaveButtonState()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let objectNameText = nameObjectTextField.text ?? ""
        let eventNameText = eventNameTextField.text ?? ""
        let eventTypeText = eventTypeTextField.text ?? ""
        let addressText = addressTextField.text ?? ""
        let eventDateText = dateFormatter.string(from: evenDateDatePicker.date)
        
        self.object = Requests(requestID: lastRequestID, objectName: objectNameText, eventDate: eventDateText, eventName: eventNameText, eventType: eventTypeText, address: addressText)
    }

}

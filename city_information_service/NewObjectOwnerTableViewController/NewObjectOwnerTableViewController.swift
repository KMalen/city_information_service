//
//  NewObjectOwnerTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/28/20.
//

import UIKit

class NewObjectOwnerTableViewController: UITableViewController {
    
    
    @IBOutlet weak var nameObjectTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var ownerTypeTextField: UITextField!
    @IBOutlet weak var ownerPhoneTextField: UITextField!
    @IBOutlet weak var openingDateDatePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var lastOwner = 0
    var lastOwnerID = 0
    
    var object = ObjectOwner(ownerID: 0, objectName: "", ownerName: "", ownerType: "", ownerPhone: "", openingDate: "" )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState(){
        let objectNameText = nameObjectTextField.text ?? ""
        let ownerNameText = ownerNameTextField.text ?? ""
        let ownerTypeText = ownerTypeTextField.text ?? ""
        let ownerPhoneText = ownerPhoneTextField.text ?? ""
        
        saveButton.isEnabled = !objectNameText.isEmpty && !ownerNameText.isEmpty && !ownerTypeText.isEmpty && !ownerPhoneText.isEmpty
    }
    
    private func updateUI(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        lastOwnerID = lastOwner
        
        nameObjectTextField.text = object.objectName
        ownerNameTextField.text = object.ownerName
        ownerTypeTextField.text = object.ownerType
        ownerPhoneTextField.text = object.ownerPhone
        openingDateDatePicker.date = dateFormatter.date(from: object.openingDate) ?? Date()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard  segue.identifier == "saveSegue" else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let objectNameText = nameObjectTextField.text ?? ""
        let ownerNameText = ownerNameTextField.text ?? ""
        let ownerTypeText = ownerTypeTextField.text ?? ""
        let ownerPhoneText = ownerPhoneTextField.text ?? ""
        let openingDateText = dateFormatter.string(from: openingDateDatePicker.date)
        
        
        self.object = ObjectOwner(ownerID: lastOwnerID, objectName: objectNameText, ownerName: ownerNameText, ownerType: ownerTypeText, ownerPhone: ownerPhoneText, openingDate: openingDateText)
    }

}

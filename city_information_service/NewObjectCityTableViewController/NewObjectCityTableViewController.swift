//
//  NewObjectCityTableViewController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/25/20.
//

import UIKit

class NewObjectCityTableViewController: UITableViewController {
    
    var object = CityObject(objectName: "", typeObject: "", adressObject: "", placesInObject: 0, ownerObject: "", seasonalityObject: "")

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var placesTextField: UITextField!
    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var seasonalityTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let typeText = typeTextField.text ?? ""
        let addressText = addressTextField.text ?? ""
        let placesText = Int(placesTextField.text ?? String(0))
        let ownerText = ownerTextField.text ?? ""
        let seasonalityText = seasonalityTextField.text ?? ""
        
        saveButton.isEnabled = !nameText.isEmpty && !typeText.isEmpty && !addressText.isEmpty
            && placesText ?? 0 > 0 && !ownerText.isEmpty && !seasonalityText.isEmpty
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }

        let nameText = nameTextField.text ?? ""
        let typeText = typeTextField.text ?? ""
        let addressText = addressTextField.text ?? ""
        let placesText = Int(placesTextField.text ?? String(0))
        let ownerText = ownerTextField.text ?? ""
        let seasonalityText = seasonalityTextField.text ?? ""
        
        self.object = CityObject(objectName: nameText, typeObject: typeText, adressObject: addressText, placesInObject: placesText!, ownerObject: ownerText, seasonalityObject: seasonalityText)
    }

}

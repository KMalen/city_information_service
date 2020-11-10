//
//  ObjectOwner.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/28/20.
//

import Foundation

class ObjectOwner {
    
    var ownerName: String
    var ownerType: String
    var ownerPhone: String
    var openingDate: String
    
    init(ownerName: String, ownerType: String, ownerPhone: String, openingDate: String) {
        
        self.ownerName = ownerName
        self.ownerType = ownerType
        self.ownerPhone = ownerPhone
        self.openingDate = openingDate
        
    }
    
}

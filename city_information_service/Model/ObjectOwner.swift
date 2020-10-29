//
//  ObjectOwner.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/28/20.
//

import Foundation

class ObjectOwner {
    
    var ownerID: Int
    var objectName: String
    var ownerName: String
    var ownerType: String
    var ownerPhone: String
    var openingDate: String
    
    init(ownerID: Int, objectName: String, ownerName: String, ownerType: String, ownerPhone: String, openingDate: String) {
        
        self.ownerID = ownerID
        self.objectName = objectName
        self.ownerName = ownerName
        self.ownerType = ownerType
        self.ownerPhone = ownerPhone
        self.openingDate = openingDate
        
    }
    
}

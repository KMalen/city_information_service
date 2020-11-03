//
//  ThirdRequest.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/3/20.
//

import Foundation

class ThirdRequest {
    
    var objectName: String
    var typeObject: String
    var addressObject: String
    var placesInObject: Int
    var ownerObject: String
    var seasonalityObject: String
    
    init(objectName: String, typeObject: String, adressObject: String, placesInObject: Int, ownerObject: String,
         seasonalityObject: String) {
        
        self.objectName = objectName
        self.typeObject = typeObject
        self.addressObject = adressObject
        self.placesInObject = placesInObject
        self.ownerObject = ownerObject
        self.seasonalityObject = seasonalityObject
        
    }
    
}

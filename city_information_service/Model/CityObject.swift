//
//  CityObjectModel.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/23/20.
//

import Foundation

class CityObject {
    
    var objectName: String
    var typeObject: String
    var adressObject: String
    var placesInObject: Int
    var ownerObject: String
    var seasonalityObject: String
    
    init(objectName: String, typeObject: String, adressObject: String, placesInObject: Int, ownerObject: String,
         seasonalityObject: String) {
        
        self.objectName = objectName
        self.typeObject = typeObject
        self.adressObject = adressObject
        self.placesInObject = placesInObject
        self.ownerObject = ownerObject
        self.seasonalityObject = seasonalityObject
        
    }
    
}

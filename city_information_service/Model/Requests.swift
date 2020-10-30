//
//  Requests.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/30/20.
//

import Foundation

class Requests {
    
    var requestID: Int
    var objectName: String
    var eventDate: String
    var eventName: String
    var eventType: String
    var address: String
    
    init(requestID: Int, objectName: String, eventDate: String, eventName: String, eventType: String, address: String) {
        
        self.requestID = requestID
        self.objectName = objectName
        self.eventDate = eventDate
        self.eventName = eventName
        self.eventType = eventType
        self.address = address
        
    }
    
}

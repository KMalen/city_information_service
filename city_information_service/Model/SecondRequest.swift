//
//  SecondRequest.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/2/20.
//

import Foundation

class SecondRequest {
    
    var eventDate: String
    var eventName: String
    var nameObject: String
    var address: String

    init(name: String, date: String, eventName: String, address: String) {
        self.eventDate = date
        self.eventName = eventName
        self.nameObject = name
        self.address = address
    }
}

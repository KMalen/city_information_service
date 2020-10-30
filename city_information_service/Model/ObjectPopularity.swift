//
//  ObjectPopularity.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/30/20.
//

import Foundation

class ObjectPopularity{
    
    var objectPopularityID: Int
    var objectName: String
    var visitDate: String
    var visits: Int
    
    init(objectPopularityID: Int, objectName: String, visitDate: String, visits: Int) {
        
        self.objectPopularityID = objectPopularityID
        self.objectName = objectName
        self.visitDate = visitDate
        self.visits = visits
    }
    
}

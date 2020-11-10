//
//  ThirdRequestController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/3/20.
//

import Foundation
import SQLite3

class ThirdRequestController {
    
    var DBHelp = DBHelper()
    var db: OpaquePointer?
    
    init() {
        db = DBHelp.openDataBase()
    }
    
    func read(typeFromUser: String) -> [ThirdRequest] {
        
        var queryStatement: OpaquePointer? = nil
        var req3 : [ThirdRequest] = []
        
        let startDate: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let queryStatementString = "SELECT * FROM city_objects WHERE type = '\(typeFromUser)' AND owner IN ( SELECT owner_name FROM objects_owner WHERE opening_date < '\(startDate)');"
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let adress = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let places = sqlite3_column_int(queryStatement, 3)
                let owner = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let seasonality = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                req3.append(ThirdRequest(objectName: name, typeObject: type, adressObject: adress, placesInObject: Int(places), ownerObject: owner, seasonalityObject: seasonality))
                
                print("Query Result:")
                print("\(name) | \(type) | \(adress) | \(places) | \(owner) | \(seasonality)")
            }
        } else {
            print("Query statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return req3
    }
}

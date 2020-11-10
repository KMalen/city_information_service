//
//  SecondRequestController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/2/20.
//

import Foundation

import SQLite3

class SecondRequestController {
    
    var DBHelp = DBHelper()
    var db: OpaquePointer?
    
    init() {
        db = DBHelp.openDataBase()
    }
    
    func read() -> [SecondRequest] {
        
        var queryStatement: OpaquePointer? = nil
        var req2 : [SecondRequest] = []
        
        let startDate: Date = Date()
        let endDate: Date = Date(timeInterval: 2 * 604800, since: startDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let queryStatementString = "SELECT event_date, event_name, name_object, address FROM requests WHERE event_date BETWEEN '\(startDate)' AND '\(endDate)';"
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let eventName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let address = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                req2.append(SecondRequest(name: name, date: date, eventName: eventName, address: address))
                
                print("Query Result:")
                print("\(date) | \(eventName) | \(name) | \(address)")
            }
        } else {
            print("Query statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return req2
    }
}

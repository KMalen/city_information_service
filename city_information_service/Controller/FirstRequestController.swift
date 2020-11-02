//
//  FirstRequestController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 11/2/20.
//

import Foundation
import SQLite3

class FirstRequestController {
    
    var DBHelp = DBHelper()
    var db: OpaquePointer?
    
    init() {
        db = DBHelp.openDataBase()
    }
    
    func read(dateFromUser: String) -> [FirstRequest] {
        
        let queryStatementString = "SELECT type, name, adress FROM city_objects WHERE name IN ( SELECT name_object FROM objects_owner WHERE opening_date < ?);"
        
        var queryStatement: OpaquePointer? = nil
        var req1 : [FirstRequest] = []
        let date: String = dateFromUser
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(queryStatement, 1, (date as NSString).utf8String, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let address = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                req1.append(FirstRequest(name: name, type: type, address: address))
                
                print("Query Result:")
                print("\(type) | \(name) | \(address)")
            }
        } else {
            print("Query statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return req1
    }
}

//
//  RequestsController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/30/20.
//

import Foundation

import SQLite3

class RequestsController{
    
    var DBHelp = DBHelper()
    var db: OpaquePointer?
    
    init() {
        db = DBHelp.openDataBase()
        createTable()
    }
    
    func dropTable() {
        let dropTableString = "DROP TABLE requests;"
        var dropTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE {
                print("requests table droped")
            } else {
                print("requests could not be droped")
            }
        } else {
            print("DROP TABLE statement could not be prepared")
        }
        sqlite3_finalize(dropTableStatement)
    }

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS requests(id INTEGER PRIMARY KEY, name_object TEXT, event_date TEXT, event_name TEXT, event_type TEXT, address TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("requests table created.")
            } else {
                print("requests could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(id:Int, nameObject:String, eventDate:String, eventName:String, eventType:String, address:String) {

            let insertStatementString = "INSERT INTO objects_owner (id, name_object, event_date, event_name, event_type, address) VALUES (?, ?, ?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(insertStatement, 1, Int32(id))
                sqlite3_bind_text(insertStatement, 2, (nameObject as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (eventDate as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (eventName as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (eventType as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, (address as NSString).utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
    
    func read() -> [Requests] {
        let queryStatementString = "SELECT * FROM requests;"
        var queryStatement: OpaquePointer? = nil
        var req : [Requests] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let objectName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let eventDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let eventName = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let eventType = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let address = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                req.append(Requests(requestID: Int(id), objectName: objectName, eventDate: eventDate, eventName: eventName, eventType: eventType, address: address))
                
                print("Query Result:")
                print("\(id) | \(objectName) | \(eventDate) | \(eventName) | \(eventType) | \(address)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return req
    }
    
    func deleteByID(id:Int) {
            let deleteStatementStirng = "DELETE FROM requests WHERE id = ?;"
            var deleteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(deleteStatement, 1, Int32(id))
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted row.")
                } else {
                    print("Could not delete row.")
                }
            } else {
                print("DELETE statement could not be prepared")
            }
            sqlite3_finalize(deleteStatement)
        }

}

//
//  ObjectOwnerController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/28/20.
//

import Foundation
import SQLite3

class ObjectOwnerController{
    
    var DBHelp = DBHelper()
    var db: OpaquePointer?
    
    init() {
        db = DBHelp.openDataBase()
        createTable()
    }
    
    func dropTable() {
        let dropTableString = "DROP TABLE objects_owner;"
        var dropTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE {
                print("objects_owner table droped")
            } else {
                print("objects_owner could not be droped")
            }
        } else {
            print("DROP TABLE statement could not be prepared")
        }
        sqlite3_finalize(dropTableStatement)
    }

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS objects_owner(owner_name TEXT PRIMARY KEY,owner_type TEXT,owner_phone TEXT,opening_date TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("objects_owner table created.")
            } else {
                print("objects_owner could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(ownerName: String, ownerType: String, ownerPhone: String, openingDate: String) {

            let insertStatementString = "INSERT INTO objects_owner (owner_name, owner_type, owner_phone, opening_date) VALUES (?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(insertStatement, 1, (ownerName as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (ownerType as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (ownerPhone as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (openingDate as NSString).utf8String, -1, nil)
                
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
    
    func update(ownerName: String, ownerType: String, ownerPhone: String, openingDate: String, updateName: String) {
        
        let updateStatementString = "UPDATE object_owner SET name = '\(ownerName)', type = '\(ownerType)', phone = '\(ownerPhone)', opening_date = '\(openingDate)' WHERE name = '\(updateName)';"
        
        var updateStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
              SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
              print("\nSuccessfully updated row.")
            } else {
              print("\nCould not update row.")
            }
          } else {
            print("\nUPDATE statement is not prepared")
          }
          sqlite3_finalize(updateStatement)
    }
    
    func read() -> [ObjectOwner] {
        let queryStatementString = "SELECT * FROM objects_owner;"
        var queryStatement: OpaquePointer? = nil
        var objOwn : [ObjectOwner] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let ownerName = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let ownerType = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let ownerPhone = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let openingDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                objOwn.append(ObjectOwner(ownerName: ownerName, ownerType: ownerType, ownerPhone: ownerPhone, openingDate: openingDate))
                
                print("Query Result:")
                print("\(ownerName) | \(ownerType) | \(ownerPhone) | \(openingDate)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return objOwn
    }
    
    func deleteByName(name: String) {
            let deleteStatementStirng = "DELETE FROM objects_owner WHERE owner_name = ?;"
            var deleteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(deleteStatement, 1, (name as NSString).utf8String, -1, nil)
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

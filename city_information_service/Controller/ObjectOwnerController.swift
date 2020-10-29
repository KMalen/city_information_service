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
                print("city objects table droped")
            } else {
                print("city objects could not be droped")
            }
        } else {
            print("DROP TABLE statement could not be prepared")
        }
        sqlite3_finalize(dropTableStatement)
    }

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS objects_owner(id INTEGER PRIMARY KEY, name_object, owner_name TEXT,owner_type TEXT,owner_phone TEXT,opening_date DATE);"
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
    
    func insert(id:Int, nameObject:String, ownerName:String, ownerType:String, ownerPhone:String, openingDate:String) {

            let insertStatementString = "INSERT INTO objects_owner (id, name_object, owner_name, owner_type, owner_phone, opening_date) VALUES (?, ?, ?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(insertStatement, 1, Int32(id))
                sqlite3_bind_text(insertStatement, 2, (nameObject as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (ownerName as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (ownerType as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (ownerPhone as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, (openingDate as NSString).utf8String, -1, nil)
                
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
    
    func read() -> [ObjectOwner] {
        let queryStatementString = "SELECT * FROM objects_owner;"
        var queryStatement: OpaquePointer? = nil
        var objOwn : [ObjectOwner] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let objectName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let ownerName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let ownerType = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let ownerPhone = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let openingDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                objOwn.append(ObjectOwner(ownerID: Int(id), objectName: objectName, ownerName: ownerName, ownerType: ownerType, ownerPhone: ownerPhone, openingDate: openingDate))
                
                print("Query Result:")
                print("\(id) | \(objectName) | \(ownerName) | \(ownerType) | \(ownerPhone) | \(openingDate)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return objOwn
    }
    
    func deleteByID(id:Int) {
            let deleteStatementStirng = "DELETE FROM objects_owner WHERE id = ?;"
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

//
//  ObjectPopularityController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/30/20.
//

import Foundation

import SQLite3

class ObjectPopularityController{
    
    var DBHelp = DBHelper()
    var db: OpaquePointer?
    
    init() {
        db = DBHelp.openDataBase()
        createTable()
    }
    
    func dropTable() {
        let dropTableString = "DROP TABLE objects_popularity;"
        var dropTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE {
                print("objects popularity table droped")
            } else {
                print("objects popularity could not be droped")
            }
        } else {
            print("DROP TABLE statement could not be prepared")
        }
        sqlite3_finalize(dropTableStatement)
    }

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS objects_popularity(id INTEGER PRIMARY KEY, name_object TEXT, visit_date TEXT,visits INTEGER, FOREIGN KEY(name_object) REFERENCES city_objects(name));"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("objects_popularity table created.")
            } else {
                print("objects_popularity could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(id:Int, nameObject:String, visitDate:String, visits:Int) {

            let insertStatementString = "INSERT INTO objects_popularity (id, name_object, visit_date, visits) VALUES (?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(insertStatement, 1, Int32(id))
                sqlite3_bind_text(insertStatement, 2, (nameObject as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (visitDate as NSString).utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 4, Int32(visits))
                
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
    
    func read() -> [ObjectPopularity] {
        let queryStatementString = "SELECT * FROM objects_popularity;"
        var queryStatement: OpaquePointer? = nil
        var objPop : [ObjectPopularity] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let objectName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let visitDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let visits = sqlite3_column_int(queryStatement, 3)
                
                objPop.append(ObjectPopularity(objectPopularityID: Int(id), objectName: objectName, visitDate: visitDate, visits: Int(visits)))
                
                print("Query Result:")
                print("\(id) | \(objectName) | \(visitDate) | \(visits)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return objPop
    }
    
    func deleteByID(id:Int) {
            let deleteStatementStirng = "DELETE FROM objects_popularity WHERE id = ?;"
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

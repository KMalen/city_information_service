//
//  ObjectCityController.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/21/20.
//

import Foundation
import SQLite3

class ObjectCityController{
    
    var DBHelp = DBHelper()
    var db: OpaquePointer?
    
    init() {
        db = DBHelp.openDataBase()
        createTable()
    }
    
    func dropTable() {
        let dropTableString = "DROP TABLE city_objects;"
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
        let createTableString = "CREATE TABLE IF NOT EXISTS city_objects(name TEXT PRIMARY KEY,type TEXT,adress TEXT,places INTEGER,owner TEXT,seasonality TEXT, FOREIGN KEY(name) REFERENCES objects_owner(owner_name));"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("city objects table created.")
            } else {
                print("city objects could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(name:String, type:String, adress:String, places:Int, owner:String, seasonality:String) {

            let insertStatementString = "INSERT INTO city_objects (name, type, adress, places, owner, seasonality) VALUES (?, ?, ?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (type as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (adress as NSString).utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 4, Int32(places))
                sqlite3_bind_text(insertStatement, 5, (owner as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, (seasonality as NSString).utf8String, -1, nil)
                
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
    
    func read() -> [CityObject] {
        let queryStatementString = "SELECT * FROM city_objects;"
        var queryStatement: OpaquePointer? = nil
        var citObj : [CityObject] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let adress = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let places = sqlite3_column_int(queryStatement, 3)
                let owner = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let seasonality = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                citObj.append(CityObject(objectName: name, typeObject: type, adressObject: adress, placesInObject: Int(places), ownerObject: owner, seasonalityObject: seasonality))
                
                print("Query Result:")
                print("\(name) | \(type) | \(adress) | \(places) | \(owner) | \(seasonality)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return citObj
    }
    
    func deleteByName(name:String) {
            let deleteStatementStirng = "DELETE FROM city_objects WHERE name = ?;"
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

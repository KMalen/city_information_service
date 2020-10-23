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

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS city_objects(name TEXT,type TEXT,adress TEXT,places INTEGER,owner TEXT,seasonality TEXT);"
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
    
    func insert(name:String, type:String, adress:String, places:Int, owner:String, seasonality:String)
        {

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

}

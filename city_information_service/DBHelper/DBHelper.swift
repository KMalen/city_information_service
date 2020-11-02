//
//  DBHelper.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/21/20.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        //db = openDataBase()
    }
    
    let dbPath: String = "myDb.sqlite"
    var db: OpaquePointer?
    var path:String = ""
    
    func openDataBase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        
        path = fileURL.path
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
}

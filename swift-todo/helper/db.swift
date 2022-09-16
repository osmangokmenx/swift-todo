//
//  db.swift
//  swift-todo
//
//  Created by Osman Gökmen on 16.09.2022.
//

import Foundation
import SQLite3
class DBHelper {
    var db : OpaquePointer?
    var path : String = "todo.sqlite"
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
            return nil
        }else {
            print("Database has been created with path \(path)")
            return db
        }
    }
    
    func createTable()  {
         let query = "CREATE TABLE IF NOT EXISTS todos(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, isDone BOOLEAN);"
         var statement : OpaquePointer? = nil
         
         if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
             if sqlite3_step(statement) == SQLITE_DONE {
                 print("Table creation success")
             }else {
                 print("Table creation fail")
             }
         } else {
             print("Prepration fail")
         }
     }
    func insert(name : String) {
            let query = "INSERT INTO todos (id, name) VALUES (?, ?);"
            
            var statement : OpaquePointer? = nil
            
            var isEmpty = false
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                if isEmpty {
                 sqlite3_bind_int(statement, 1, 1)
                }
                sqlite3_bind_text(statement, 2, (name as NSString).utf8String, -1, nil)
     
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data inserted success")
                }else {
                    print("Data is not inserted in table")
                }
            } else {
              print("Query is not as per requirement")
            }
            
        }
        
            
    func read() -> [String] {
        var mainList = [String]()
        
        let query = "SELECT * FROM your_table_name;"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            while sqlite3_step(statement) == SQLITE_ROW {
                let name = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                mainList.append(name);
            }
        }
        return mainList
    }
}

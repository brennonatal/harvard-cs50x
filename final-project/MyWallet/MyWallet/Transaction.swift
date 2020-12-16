//
//  Wallet.swift
//  MyWallet
//
//  Created by Brenno Natal on 16/12/20.
//

import Foundation
import SQLite3

struct Transaction {
    let id: Int
    let uid: String
    var name: String
    var amount: Double
    var type: String
    let date: String
}

class TransactionManager {
    var database: OpaquePointer!
    
    static let main = TransactionManager()
    
    private init() {
    }
    
    func connect() {
        if database != nil {
            return
        }
        
        do {
            let databaseURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("wallet.sqlite3")
            
            if sqlite3_open(databaseURL.path, &database) == SQLITE_OK {
                if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS transactions (uid TEXT, name TEXT, amount REAL, type TEXT, date TEXT)", nil, nil, nil) == SQLITE_OK {
                    
                }
                else {
                    print("Could not create table")
                }
                
            }
            else {
                print("Could not connect to the database")
            }
        }
        catch let error {
            print("Could not create database")
            print(error)
            
        }
    }
    
    func create(uid: String, name: String, amount: Double, type: String) -> Int {
        connect()
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "INSERT INTO transactions (uid, name, amount, type, date) VALUES (?, ?, ?, ?, date('now'))", -1, &statement, nil) != SQLITE_OK {
                print("Could not create query")
                return -1
        }
        
        sqlite3_bind_text(statement, 1, NSString(string: uid).utf8String, -1, nil)
        sqlite3_bind_text(statement, 2, NSString(string: name).utf8String, -1, nil)
        sqlite3_bind_double(statement, 3, amount)
        sqlite3_bind_text(statement, 4, NSString(string: type).utf8String, -1, nil)
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Could not insert transaction")
            return -1
        }
        
        sqlite3_finalize(statement)
        return Int(sqlite3_last_insert_rowid(database))
        
    }
    
    func getUserTransactions(uid: String) -> [Transaction] {
        connect()
        
        var result: [Transaction] = []
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "SELECT rowid, uid, name, amount, type, date FROM transactions WHERE uid LIKE ? ORDER BY rowid DESC", -1, &statement, nil) != SQLITE_OK {
            print("Error creating select")
            return result
        }
        
        sqlite3_bind_text(statement, 1, NSString(string: uid).utf8String, -1, nil)
        
        while sqlite3_step(statement) == SQLITE_ROW {
            result.append(Transaction(id: Int(sqlite3_column_int(statement, 0)), uid: String(cString: sqlite3_column_text(statement, 1)), name: String(cString: sqlite3_column_text(statement, 2)), amount: Double(sqlite3_column_double(statement, 3)), type: String(cString: sqlite3_column_text(statement, 4)), date: String(cString: sqlite3_column_text(statement, 5))))
        }
        
        sqlite3_finalize(statement)
        return result
    }
    
    func update(transaction: Transaction) {
        connect()
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "UPDATE transactions SET name = ?, amount = ?, type = ? WHERE rowid = ?", -1, &statement, nil) != SQLITE_OK {
                print("Error creating update statement")
        }
        
        sqlite3_bind_text(statement, 1, NSString(string: transaction.name).utf8String, -1, nil)
        sqlite3_bind_double(statement, 2, transaction.amount)
        sqlite3_bind_text(statement, 3, NSString(string: transaction.type).utf8String, -1, nil)
        sqlite3_bind_int(statement, 4, Int32(transaction.id))
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Error running update")
        }
        sqlite3_finalize(statement)
    }
    
    func delete(transaction: Transaction) {
        connect()
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "DELETE FROM transactions WHERE rowid = ?", -1, &statement, nil) != SQLITE_OK {
            print("Error creating delete statement")
        }
        
        sqlite3_bind_int(statement, 1, Int32(transaction.id))
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Error running delete")
        }
        sqlite3_finalize(statement)
    }
}

//
//  GRDBManager.swift
//  MultiPlatformAppCore
//
//  Created by Hg Q. on 18/6/25.
//

import Foundation
import GRDB

public class GRDBManager {
    
    public static let shared = GRDBManager()

    private var dbPool: DatabasePool!

    public init() {
        print("GRDBManager: Initialized")
    }
    
    public func openDatabase(databaseURL: URL, encryptionKey: String? = nil) {
        do {
            if encryptionKey != nil {
                // Currently, GRDB does not support encryption directly.
            } else {
                // Setup without encryption
                dbPool = try DatabasePool(path: databaseURL.path)
            }
        } catch {
            print("GRDBManager: Error opening or migrating database: \(error)")
        }
    }
    
    public func migrateDatabase() {
        do {
            try migrator.migrate(dbPool)
            print("GRDBManager: Database migrated successfully.")
        } catch {
            print("GRDBManager: Error migrating database: \(error)")
        }
    }
    
    // MARK: - Database Migrations
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.eraseDatabaseOnSchemaChange = true

        migrator.registerMigration("createUserTable") { db in
            try db
                .create(table: User.databaseTableName, ifNotExists: true) { t in
                t.autoIncrementedPrimaryKey(User.Columns.id.name)
                
                    t.column(User.Columns.username.name, .text).notNull()
                    t.column(User.Columns.email.name, .text).notNull()
            }
        }
        
        return migrator
    }
    
    
    // MARK: - Database Operations
    
    public func insertUser(user: User?) -> User? {
        guard let user = user else {
            print("Error: User is nil")
            return nil
        }
        
        var savedUser = user
        do {
            try dbPool.write { db in
                try savedUser.save(db)
            }
            
            return savedUser
            
        } catch {
            print("Error saving user: \(error)")
            return nil
        }
    }
    
    public func fetchUsers() -> [User] {
        do {
            return try dbPool.read { db in
                try User.fetchAll(db)
            }
        } catch {
            print("Error fetching users: \(error)")
            return []
        }
    }
}

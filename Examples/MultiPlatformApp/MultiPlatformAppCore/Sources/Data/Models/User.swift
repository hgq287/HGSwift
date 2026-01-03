//
//  User.swift
//  MultiPlatformAppCore
//
//  Created by Hg Q. on 18/6/25.
//

import Foundation
import GRDB

public struct User: BaseModel {
    public var id: Int64?
    public var username: String
    public var email: String
    
    public init(id: Int64? = nil, username: String, email: String) {
        self.id = id
        self.username = username
        self.email = email
    }
    
    // Additional methods or computed properties can be added here if needed
}

// MARK: - GRDB Protocols

extension User: FetchableRecord, MutablePersistableRecord {

    public static var databaseTableName: String { "user" }

    public enum Columns {
        static let id = Column("id")
        static let username = Column("username")
        static let email = Column("email")
    }
    
    // Update auto-incremented id upon successful insertion
    mutating public func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
    
    // MARK: - init
    public init(row: Row) throws {
        id = row[Columns.id]
        username = row[Columns.username]
        email = row[Columns.email]
    }

    // MARK: - encode
    public func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.username] = username
        container[Columns.email] = email
    }
    
}

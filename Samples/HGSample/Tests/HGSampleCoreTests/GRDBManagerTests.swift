//
//  GRDBManagerTests.swift
//  HGSampleCoreTests
//
//  Created by Hg Q. on 5/7/25.
//

import XCTest
import GRDB
@testable import HGSampleCore

final class GRDBManagerTests: XCTestCase {
    var grdbManager: GRDBManager!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        grdbManager = GRDBManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        grdbManager = nil
    }
    
    func testSharedInstance() {
         XCTAssertNotNil(GRDBManager.shared)
         XCTAssertTrue(GRDBManager.shared === GRDBManager.shared) // Ensure it's a singleton
     }
    
    func testDatabaseInitialization() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: path).appendingPathComponent("test_grdb.sqlite")
        grdbManager.openDatabase(databaseURL: dbURL)

        XCTAssertTrue(FileManager.default.fileExists(atPath: dbURL.path), "Database file should exist")
    }
    
    func testMigrateDatabase_createUserTable() throws {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: path).appendingPathComponent("test_grdb.sqlite")
        
        if FileManager.default.fileExists(atPath: dbURL.path) {
            // remove existing database file for a clean test
            try FileManager.default.removeItem(at: dbURL)
        }
        

        grdbManager.openDatabase(databaseURL: dbURL)
        grdbManager.migrateDatabase()

        // Open the database and check if the User table exists
        var configuration = Configuration()
        configuration.readonly = true
        let dbQueue = try DatabaseQueue(path: dbURL.path, configuration: configuration)

        try dbQueue.read { db in
            let tableExists = try db.tableExists(User.databaseTableName)
            XCTAssertTrue(tableExists, "User table should be created after migration.")
        }

        // Clean up the test database file
        try FileManager.default.removeItem(at: dbURL)
    }
    
    func testInsertUser() throws {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: path).appendingPathComponent("test_grdb.sqlite")
        
        if FileManager.default.fileExists(atPath: dbURL.path) {
            // remove existing database file for a clean test
            try FileManager.default.removeItem(at: dbURL)
        }
        
        grdbManager.openDatabase(databaseURL: dbURL)
        grdbManager.migrateDatabase()
        
        let user = User(username: "john", email: "email@example.com")
        let insertedUser = grdbManager.insertUser(user: user)
        XCTAssertNotNil(insertedUser, "Inserted user should not be nil")
    }
    
    func testFetchUsers() throws {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: path).appendingPathComponent("test_grdb.sqlite")
        
        if FileManager.default.fileExists(atPath: dbURL.path) {
            // remove existing database file for a clean test
            try FileManager.default.removeItem(at: dbURL)
        }
        
        grdbManager.openDatabase(databaseURL: dbURL)
        grdbManager.migrateDatabase()
        
        let user1 = User(username: "john", email: "john@example.com")
        _ = grdbManager.insertUser(user: user1)
        let user2 = User(username: "jane", email: "jane@example.com")
        _ = grdbManager.insertUser(user: user2)
                         
        let users = grdbManager.fetchUsers()
        XCTAssertEqual(users.count, 2, "There should be 2 users in the database")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

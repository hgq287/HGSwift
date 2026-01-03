//
//  AuthService.swift
//  Shared
//
//  Created by Hung Q. on 25/6/25.
//

import Foundation

public protocol AuthServiceProtocol {
    func login(username: String, password: String) async -> Bool
    func register(username: String, password: String) async -> Bool
}

public struct AuthService: AuthServiceProtocol {
    
    public init() {
        print("AuthService initialized")
    }
    
    public func login(username: String, password: String) async -> Bool {
        try? await Task.sleep(nanoseconds: 500_000_000)
        return username == "admin" && password == "@123"
    }

    public func register(username: String, password: String) async -> Bool {
        try? await Task.sleep(nanoseconds: 500_000_000)
        return !username.isEmpty && !password.isEmpty
    }
}

public struct MockAuthService: AuthServiceProtocol {
    
    public init() {
        print("MockAuthService initialized")
    }
    
    public func login(username: String, password: String) async -> Bool {
        return username.lowercased() == "test" && password == "password"
    }

    public func register(username: String, password: String) async -> Bool {
        return username.lowercased() != "admin" && password.count >= 4
    }
}

//
//  AuthRepository.swift
//  Shared
//
//  Created by Hg Q. on 25/6/25.
//

import Foundation

public protocol AuthRepositoryProtocol {
    func login(username: String, password: String) async -> Bool
    func register(username: String, password: String) async -> Bool
}

public struct AuthRepository: AuthRepositoryProtocol {
    private let service: AuthServiceProtocol

    public init(service: AuthServiceProtocol) {
        self.service = service
    }

    public func login(username: String, password: String) async -> Bool {
        await service.login(username: username, password: password)
    }

    public func register(username: String, password: String) async -> Bool {
        await service.register(username: username, password: password)
    }
}

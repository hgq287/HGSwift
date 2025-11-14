//
//  AppState.swift
//  HGSample
//
//  Created by Hg Q. on 24/6/25.
//

import Foundation
import HGSampleCore
import Shared

public final class AppState: ObservableObject {
    
    // MARK: - Login State
    @Published var isLoggedIn: Bool = false
    
    // MARK: - Core Managers & Models
    @Published public var dbManager: GRDBManager
    
    // MARK: - Repositories (Data access layer)
    @Published public var authRepository: AuthRepositoryProtocol
    
    // MARK: - Services (Network, Database, etc.)
    @Published public var authService: AuthServiceProtocol
    
    // MARK: - Interactors (Feature-specific logic)
    @Published public var authInteractor: AuthInteractor
    @Published public var mainInteractor: MainInteractor = MainInteractor()
    
    // MARK: - Initializer
    public init() {
        let databaseURL = AppConfig.databaseURL!
        let _sharedDBManager = GRDBManager.shared
        _sharedDBManager.openDatabase(databaseURL: databaseURL)
        _sharedDBManager.migrateDatabase()
        
        self.dbManager = _sharedDBManager
        
        let _authService = AuthService()
        self.authService = _authService
        
        let _authRepository = AuthRepository(service: _authService)
        self.authRepository = _authRepository
        
        self.authInteractor = AuthInteractor(repository: _authRepository)
    }
    
    // MARK: - App Lifecycle Methods
    public func startup() {
        print("AppState: Startup sequence initiated, initializing database...")
    }
    
    public func shutdown() {
        print("AppState: Shutdown sequence initiated, stopping all services...")
    }
}

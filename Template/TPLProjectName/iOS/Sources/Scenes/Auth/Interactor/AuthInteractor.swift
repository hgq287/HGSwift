//
//  AuthInteractor.swift
//  TPLProjectName
//
//  Created by TPLAuthor on 24/6/25.
//

import Foundation
import Shared

public final class AuthInteractor: ObservableObject {
    
    enum Mode: String, Hashable, CaseIterable {
        case signIn = "Sign In"
        case signUp = "Sign Up"
    }

    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    @Published var mode: Mode = .signIn

    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func submit() {
        Task {
            isLoading = true
            errorMessage = nil

            let result: Bool
            switch mode {
            case .signIn:
                result = await repository.login(username: username, password: password)
            case .signUp:
                result = await repository.register(username: username, password: password)
            }

            isLoading = false
            isLoggedIn = result

            if !result {
                errorMessage = "Authentication failed"
            }
        }
    }
    
}

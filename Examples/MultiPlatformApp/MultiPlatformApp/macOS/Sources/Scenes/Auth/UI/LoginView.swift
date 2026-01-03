//
//  LoginView.swift
//  MultiPlatformApp
//
//  Created by Hg Q. on 24/6/25.
//

import SwiftUI
import Shared

struct LoginView: View {
    @EnvironmentObject var appstate: AppState
    @EnvironmentObject var authInteractor: AuthInteractor

    var body: some View {
        VStack(spacing: 20) {
            Picker("Authentication Mode", selection: $authInteractor.mode) {
                ForEach(AuthInteractor.Mode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)

            TextField("Username", text: $authInteractor.username)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $authInteractor.password)
                .textFieldStyle(.roundedBorder)

            if authInteractor.isLoading {
                ProgressView()
            } else {
                Button(authInteractor.mode == .signIn ? "Sign In" : "Sign Up") {
                    authInteractor.submit()
                }
                .buttonStyle(.borderedProminent)
            }

            if let error = authInteractor.errorMessage {
                Text(error).foregroundColor(.red)
            }
        }
        .padding()
        /// create views after login
        .onChange(of: authInteractor.isLoggedIn) { isLoggedIn in
            if isLoggedIn {
                appstate.isLoggedIn = true
            }
        }
    }
}

#Preview {
    LoginView()
}

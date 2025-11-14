//
//  ContentView.swift
//  HGSample
//
//  Created by Hg Q. on 20/4/25.
//

import SwiftUI
import HGSampleCore

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if appState.isLoggedIn {
            HomeView()
                .environmentObject(appState.mainInteractor)
        } else {
            LoginView()
                .environmentObject(appState)
                .environmentObject(appState.authInteractor)
            
            .onAppear {
                // Perform any setup required when the view appears
                appState.startup()
            }
            .onDisappear {
                // Perform any cleanup if necessary
                appState.shutdown()
            }
        }
            
    
    }
      
}

#Preview {
    ContentView()
}

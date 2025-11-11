//
//  TPLProjectNameApp.swift
//  TPLProjectName
//
//  Created by TPLAuthor on 20/4/25.
//

import SwiftUI

@main
struct TPLProjectNameApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

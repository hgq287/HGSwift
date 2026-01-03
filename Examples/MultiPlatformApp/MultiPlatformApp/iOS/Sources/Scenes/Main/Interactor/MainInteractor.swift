//
//  HomeView.swift
//  MainInteractor
//
//  Created by Hg Q. on 11/11/25.
//

import Foundation
import Shared

public final class MainInteractor: ObservableObject {
    
    @Published var welcomeMessage: String = ""

    init() {}
    
    func fetchWelcomeMessage() {
        Task {
            // Simulate network delay
            try? await Task.sleep(nanoseconds: 300_000_000)
            welcomeMessage = "Hi! Enjoy using MultiPlatformApp."
        }
    }
    
}

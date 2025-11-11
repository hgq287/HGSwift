//
//  HomeView.swift
//  TPLProjectName
//
//  Created by TPLAuthor on 11/11/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mainInteractor: MainInteractor
    var body: some View {
        VStack(spacing: 0) {
            Text(mainInteractor.welcomeMessage)
                .font(.title)
                .fontWeight(.medium)
            Text("Successfully logged in")
                .foregroundColor(.secondary)
        }
        .cornerRadius(0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.white))
        .onAppear {
            mainInteractor.fetchWelcomeMessage()
        }
    }
}

#Preview {
    HomeView()
}

//
//  SplashScreen.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/11/25.
//

import SwiftUI

struct SplashScreen: View {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false

    var body: some View {
        VStack {
            Text("Welcome to the Flashcard App!")
                .font(.largeTitle)
                .bold()
                .padding()
            Text("This app helps you study flashcards and improve your knowledge.\nAdd decks and cards to decks to study!\nSwipe right if you knew the answer and left if you didn't!")
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            // Dismiss button
            Button("Dismiss") {
                hasLaunchedBefore = true // Set flag to true to avoid showing this again
            }
            .buttonStyle(.bordered)
            .padding(.bottom, 50)
        }
        .padding()
        .background(Color(.green))
    }
}

#Preview {
    SplashScreen()
}

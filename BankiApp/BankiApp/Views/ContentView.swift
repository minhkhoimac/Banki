//
//  ContentView.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var dataManager = DataManager()
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @State private var showRatingAlert = false
    @State private var launchCount: Int = UserDefaults.standard.integer(forKey: "launchCount")
    
    var body: some View {
        if hasLaunchedBefore {
            TabView {
                // View to view all created decks
                DecksView()
                    .tabItem {
                        Label("Decks", systemImage: "folder")
                    }
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                
                StudyView()
                    .tabItem {
                        Label("Study", systemImage: "book.fill")
                    }
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                
                UserView()
                    .tabItem {
                        Label("User", systemImage: "person")
                    }
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
            .environmentObject(DataManager())
            .onAppear {
                print(launchCount)
                if launchCount == 3 {
                    showRatingAlert = true
                }
            }
            .alert(isPresented: $showRatingAlert) {
                Alert(
                    title: Text("Rate This App"),
                    message: Text("If you enjoy using this app, please take a moment to rate it in the App Store.\n Does not work because not in App Store, just here for project requirements."),
                    primaryButton: .default(Text("Rate Now"), action: {
                        rateApp()
                    }),
                    secondaryButton: .cancel(Text("Later"))
                )
            }
        } else {
            SplashScreen()
                .transition(.opacity)
        }
    }
    
    private func rateApp() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/BANKI_APP_ID") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataManager())
}

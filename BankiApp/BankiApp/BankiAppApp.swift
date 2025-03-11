//
//  BankiAppApp.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/11/25.
//

import SwiftUI

@main
struct BankiAppApp: App {
    @StateObject var dataManager = DataManager()
    init() {
        // Register default values if they don't already exist
        let defaults = UserDefaults.standard
        let appDefaults: [String: Any] = [
            "InitialLaunch": NSDate(), // Store the first launch date
            "darkModeEnabled": false   // Default to light mode
        ]
        defaults.register(defaults: appDefaults)
        
        if defaults.integer(forKey: "launchCount") == 0 {
            defaults.set(1, forKey: "launchCount")
        } else {
            let launchCount = defaults.integer(forKey: "launchCount") + 1
            defaults.set(launchCount, forKey: "launchCount")
        }

        // Check if this is the first launch
        if defaults.object(forKey: "InitialLaunch") == nil {
            // If it's the first launch, store the current date as the first launch date
            defaults.set(NSDate(), forKey: "InitialLaunch")
            defaults.synchronize() // Save immediately
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataManager())
        }
    }
}

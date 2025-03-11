//
//  UserView.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/10/25.
//

import SwiftUI

struct UserView: View {
    @AppStorage("username") private var username: String = ""
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("selectedDeckName") private var selectedDeckName: String = "Spanish Verbs"

    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Enter your name", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }

                Section(header: Text("Select Deck")) {
                    Picker("Study Deck", selection: $selectedDeckName) {
                        ForEach(dataManager.decks, id: \.name) { deck in
                            Text(deck.name).tag(deck.name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .navigationTitle("Settings")
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .onAppear {
                if selectedDeckName.isEmpty, let firstDeck = dataManager.decks.first {
                    selectedDeckName = firstDeck.name // Default selection
                }
            }
        }
    }
}



#Preview {
    UserView()
        .environmentObject(DataManager())
}

//
//  DecksView.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/10/25.
//

import SwiftUI

struct DecksView: View {
    @EnvironmentObject var dataManager: DataManager

    @State private var newDeckName = ""
    @State private var newDeckColor: Color = .blue
    @State private var isDeleting = false // For jiggle animation
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())] // 2-column grid layout

    var body: some View {
        NavigationStack {
            VStack {
                DeckGridView(isDeleting: $isDeleting)

                HStack {
                    TextField("New Deck Name", text: $newDeckName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    // color picker for new deck
                    ColorPicker("", selection: $newDeckColor)
                        .labelsHidden() // Hide label to keep it compact

                    // add deck
                    Button("Add") {
                        addDeck()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
            .navigationTitle("My Decks")
        }
    }
    
    // add empty deck and persist to UserDefaults
    private func addDeck() {
        guard !newDeckName.isEmpty else { return }
        let newDeck = Deck(name: newDeckName, cards: [], color: newDeckColor)
        dataManager.decks.append(newDeck)
        dataManager.saveDecks()
        newDeckName = ""
        newDeckColor = .blue
    }
}

#Preview {
    DecksView()
        .environmentObject(DataManager())
}

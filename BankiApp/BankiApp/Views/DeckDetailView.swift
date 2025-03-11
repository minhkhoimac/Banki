//
//  DeckDetailView.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/10/25.
//

import SwiftUI

struct DeckDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    var deck: Deck
    @State private var refreshedDeck: Deck
    
    init(deck: Deck) {
        self.deck = deck
        _refreshedDeck = State(initialValue: deck) // Local state for refreshing
    }

    // text fields to add new card
    @State private var newQuestion = ""
    @State private var newAnswer = ""

    var body: some View {
        VStack {
            List {
                ForEach(refreshedDeck.cards) { card in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Q: \(card.question)").bold()
                            Text("A: \(card.answer)")
                        }
                        Spacer()
                        Text("\(card.timesCorrect) correct out of \(card.timesShown) times reviewed")
                    }
                }
                .onDelete(perform: deleteCard)
            }
            .refreshable {
                loadDeckFromUserDefaults()
            }

            VStack {
                TextField("Question", text: $newQuestion)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Answer", text: $newAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Add Card") {
                    // add card to deck with binding newQuestion and newAnswer
                    addCard()
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle(deck.name)
    }
    
    // refresh deck
    private func loadDeckFromUserDefaults() {
        if let updatedDeck = dataManager.decks.first(where: { $0.name == deck.name }) {
            refreshedDeck = updatedDeck // Reload deck data
        }
    }
    
    // add card to deck and persist to UserDefaults
    private func addCard() {
        guard !newQuestion.isEmpty, !newAnswer.isEmpty else { return }
        let newCard = Card(question: newQuestion, answer: newAnswer)
        
        if let index = dataManager.decks.firstIndex(where: { $0.id == deck.id }) {
            dataManager.decks[index].cards.append(newCard)
            dataManager.saveDecks()
            loadDeckFromUserDefaults()
        }
        
        newQuestion = ""
        newAnswer = ""
    }

    // remove card to deck and persist to UserDefaults
    private func deleteCard(at offsets: IndexSet) {
        if let index = dataManager.decks.firstIndex(where: { $0.id == deck.id }) {
            dataManager.decks[index].cards.remove(atOffsets: offsets)
            dataManager.saveDecks()
            loadDeckFromUserDefaults()
        }
    }
}


#Preview {
    DeckDetailView(deck: .example)
        .environmentObject(DataManager())
}

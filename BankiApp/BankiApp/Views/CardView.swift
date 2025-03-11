//
//  CardView.swift
//  flashly
//
//  Created by minhkhoi mac on 3/9/25.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var dataManager: DataManager
    
    // boolean to keep track if user wants answer to appear
    @State private var revealAnswer = false
    
    // value to determine user swiping degree
    @State private var offset = CGSize.zero
    
    // selected deck to study, chosen from UserView
    @AppStorage("selectedDeckName") private var selectedDeckName: String = ""
    
    // locally stored ordering of deck to show users
    @State private var orderedDeck: [Card] = []
    @State private var currentIndex: Int = 0

    var selectedDeck: Deck? {
        dataManager.decks.first { $0.name == selectedDeckName }
    }
    
    var body: some View {
        VStack {
            if !orderedDeck.isEmpty {
                let card = orderedDeck[currentIndex]
                
                // ZStack to view card
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.green))
                    VStack {
                        Text(card.question)
                            .font(.largeTitle)
                        if revealAnswer {
                            Text(card.answer)
                                .font(.title)
                        }
                    }
                    .padding(20)
                    .multilineTextAlignment(.center)
                }
                .rotationEffect(.degrees(offset.width / 5.0))
                .offset(x: offset.width)
                .opacity(2 - Double(abs(offset.width / 50)))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            if abs(offset.width) > 100 {
                                handleSwipe()
                            }
                            offset = .zero
                        }
                )
                .onTapGesture {
                    revealAnswer.toggle()
                }
            } else {
                // if deck is empty, notify user
                Text("No cards available in the selected deck.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .onAppear {
            if let deck = selectedDeck {
                orderedDeck = deck.cards.sorted { $0.ordering < $1.ordering }
            }
        }
    }

    // function to help persist each card after review to UserDefaults
    private func handleSwipe() {
        guard !orderedDeck.isEmpty, let deckIndex = dataManager.decks.firstIndex(where: { $0.name == selectedDeckName }) else { return }

        let card = orderedDeck[currentIndex]
        
        // Find the corresponding card in the main deck
        if let cardIndex = dataManager.decks[deckIndex].cards.firstIndex(where: { $0.id == card.id }) {
            dataManager.decks[deckIndex].cards[cardIndex].timesShown += 1

            if offset.width > 100 {
                // Swiped right (correct)
                dataManager.decks[deckIndex].cards[cardIndex].timesCorrect += 1
                dataManager.decks[deckIndex].cards[cardIndex].ordering *= 1.5
            } else if offset.width < -100 {
                // Swiped left (incorrect)
                dataManager.decks[deckIndex].cards[cardIndex].ordering *= 1.1
            }
        }
        
        // Save changes to UserDefaults
        dataManager.saveDecks()
        
        // Move to the next card
        currentIndex = (currentIndex + 1) % orderedDeck.count

        // Hide answer for next card
        revealAnswer = false
    }
}


#Preview {
    CardView()
        .environmentObject(DataManager())
}

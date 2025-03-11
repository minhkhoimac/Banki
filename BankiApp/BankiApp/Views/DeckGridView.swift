//
//  DeckGridView.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/10/25.
//

import SwiftUI

struct DeckGridView: View {
    @EnvironmentObject var dataManager: DataManager
    @Binding var isDeleting: Bool

    let columns = [GridItem(.flexible()), GridItem(.flexible())] // 2-column grid

    // Grid collections view for decks
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(dataManager.decks.indices, id: \.self) { index in
                    let deck = dataManager.decks[index]
                    
                    NavigationLink(destination: DeckDetailView(deck: deck)) {
                        // go to DeckDetailView
                        DeckTileView(deck: deck, isDeleting: isDeleting)
                    }
                    .onLongPressGesture {
                        // delete deck
                        withAnimation {
                            isDeleting.toggle()
                        }
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            deleteDeck(index: index)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    // remove deck when users hold deck
    private func deleteDeck(index: Int) {
        dataManager.decks.remove(at: index)
        dataManager.saveDecks()
    }
}


#Preview {
    // resource: preview with binding
    // https://www.reddit.com/r/SwiftUI/comments/17aruvw/preview_with_binding_properties/
    struct Preview: View {
        @State var isDeleting = false
        var body: some View {
            DeckGridView(isDeleting: $isDeleting)
                .environmentObject(DataManager())
        }
    }

    return Preview()
}

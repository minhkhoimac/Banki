//
//  DeckTileView.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/10/25.
//

import SwiftUI

struct DeckTileView: View {
    var deck: Deck
    var isDeleting: Bool
    
    var body: some View {
        VStack {
            Text(deck.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(deck.color)
                .cornerRadius(15)
                .scaleEffect(isDeleting ? 1.05 : 1.0) // Jiggle animation
                .rotationEffect(isDeleting ? Angle(degrees: 2) : .zero)
                .animation(isDeleting ? Animation.default.repeatForever(autoreverses: true) : .default, value: isDeleting)
        }
    }
}


#Preview {
    DeckTileView(deck: .example, isDeleting: false)
        .environmentObject(DataManager())
}

//
//  StudyView.swift
//  BankiApp
//
//  Created by minhkhoi mac on 3/10/25.
//

import SwiftUI

struct StudyView: View {
    @EnvironmentObject var dataManager: DataManager

    // Second tab
    var body: some View {
        NavigationStack {
            VStack {
                CardView()
                    .navigationTitle("Study Mode")
                // instructions for user
                Text("Swipe right if you knew the answer, swipe left if you did not know. Tap to reveal the answer.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}


#Preview {
    StudyView()
        .environmentObject(DataManager())
}

//
//  TriviaView.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 3.08.2025.
//

import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager

    var body: some View {
        if triviaManager.reachedEnd {
            VStack(spacing: 20) {
                Text("Quizly Game")
                    .lilacTitle()
                
                Text("Congratulations, you completed the game! 🥳")
                Text("You scored \(triviaManager.score) out of \(triviaManager.length)")
                
                Button {
                    Task.init {
                        await triviaManager.fetchTrivia()
                    }
                } label: {
                    PrimaryButton(text: "Play Again")
                }
            }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.9843, green: 0.9294, blue: 0.84705))

        } else {
            QuestionView()
                .environmentObject(triviaManager)
        }
    }
}

#Preview {
    TriviaView()
        .environmentObject(TriviaManager())
}

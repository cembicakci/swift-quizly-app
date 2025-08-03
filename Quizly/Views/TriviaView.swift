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
        QuestionView()
            .environmentObject(triviaManager)
    }
}

#Preview {
    TriviaView()
        .environmentObject(TriviaManager())
}

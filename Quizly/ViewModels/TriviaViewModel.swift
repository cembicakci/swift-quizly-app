//
//  TriviaViewModel.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 5.08.2025.
//

import Foundation
import SwiftUI

@MainActor
class TriviaViewModel: ObservableObject {
    // Quiz Data
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var length = 0

    // Current Question
    @Published private(set) var index = 0
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []

    // Score & Progress
    @Published private(set) var progress: CGFloat = 0.0
    @Published private(set) var score = 0

    // State Flags
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    
    init() {
        Task {
            await loadTrivia()
        }
    }
    
    func loadTrivia() async {
        do {
            let results = try await NetworkManager.shared.fetchTrivia()
            trivia = results
            length = trivia.count
            index = 0
            score = 0
            progress = 0.0
            reachedEnd = false
            setQuestion()
        } catch {
            print("Failed to load trivia: \(error)")
        }
    }

    func goToNextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }

    func setQuestion() {
        guard index < length else { return }

        let current = trivia[index]
        question = current.formattedQuestion
        answerChoices = current.answers
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
    }

    func selectAnswer(_ answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
}


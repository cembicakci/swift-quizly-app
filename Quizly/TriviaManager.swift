//
//  TriviaManager.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 3.08.2025.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject {
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var length = 0
    
    // Variables to set question and answers
    @Published private(set) var index = 0
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    
    // Variables for score and progress
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    
    // Variables to know if an answer has been selected and reached the end of trivia
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    
    init() {
        Task.init {
            await fetchTrivia()
        }
    }
    
    // Asynchronous HTTP request to get the trivia questions and answers
    func fetchTrivia() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let(data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let decodedData = try decoder.decode(Trivia.self, from: data)

            DispatchQueue.main.async {
                // Reset variables before assigning new values, for when the user plays the game another time
               self.index = 0
               self.score = 0
               self.progress = 0.00
               self.reachedEnd = false

               // Set new values for all variables
               self.trivia = decodedData.results
               self.length = self.trivia.count
               self.setQuestion()
            }
        } catch {
            print("Error fetching trivia: \(error)")
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
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        
        if index < length {
            let currentQuestion = trivia[index]
            question = currentQuestion.formattedQuestion
            answerChoices = currentQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        
        if answer.isCorrect {
            score += 1
        }
    }
}

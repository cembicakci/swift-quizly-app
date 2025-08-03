//
//  QuestionView.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 3.08.2025.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        VStack (spacing: 40) {
            HStack {
                Text("Quizly Game")
                    .lilacTitle()
                
                Spacer()
                
                Text("\(triviaManager.index + 1) out of \(triviaManager.length)")
                    .foregroundStyle(Color("AccentColor"))
                    .fontWeight(.heavy)
            }
            
            ProgressBar(progress: triviaManager.progress)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(triviaManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.gray)
                
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(triviaManager)
                }
            }
            
            Button {
                triviaManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Next", background: triviaManager.answerSelected ? Color("AccentColor") : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!triviaManager.answerSelected)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.9843, green: 0.9294, blue: 0.84705))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    QuestionView()
        .environmentObject(TriviaManager())
}

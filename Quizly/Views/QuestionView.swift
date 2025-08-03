//
//  QuestionView.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 3.08.2025.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        VStack (spacing: 40) {
            HStack {
                Text("Quizly Game")
                    .lilacTitle()
                Spacer()
                Text("1 out of 10")
                    .foregroundStyle(Color("AccentColor"))
                    .fontWeight(.heavy)
            }
            
            ProgressBar(progress: 40)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("What is Lilo&#039;s last name from Lilo and Stitch?")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.9843, green: 0.9294, blue: 0.84705))
    }
}

#Preview {
    QuestionView()
}

//
//  ContentView.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 2.08.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var triviaManager = TriviaViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Quizly")
                        .lilacTitle()
                    
                    Text("Are u ready to test out your skills?")
                        .foregroundStyle(Color("AccentColor"))
                }
                
                NavigationLink {
                    TriviaView()
                        .environmentObject(triviaManager)
                } label: {
                    PrimaryButton(text: "Let's Go!")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(red: 0.9843, green: 0.9294, blue: 0.84705))
        }
    }
}

#Preview {
    ContentView()
}

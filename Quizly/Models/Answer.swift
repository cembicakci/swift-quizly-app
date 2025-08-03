//
//  Answer.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 3.08.2025.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID();
    var text: AttributedString
    var isCorrect: Bool
}

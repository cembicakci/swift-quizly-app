//
//  Extensions.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 2.08.2025.
//

import Foundation
import SwiftUI

extension Text {
    func lilacTitle () -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundStyle(Color("AccentColor"))
    }
}

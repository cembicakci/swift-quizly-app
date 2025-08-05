//
//  NetworkManager.swift
//  Quizly
//
//  Created by Cem Bıçakcı on 5.08.2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchTrivia(amount: Int = 10) async throws -> [Trivia.Result] {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)") else {
            throw URLError(.badURL)
        }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let decodedData = try decoder.decode(Trivia.self, from: data)
        return decodedData.results
    }
}

//
//  InspirationQuoteService.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 12/08/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case noDataReceived
    case networkError(Error)
}

struct Quote: Decodable {
    let q: String
    let a: String
}

/* Capstone requirement 10 & 11 - Use quote API for daily inspiration quote and handle nework errors*/
class InspirationQuoteService {
    func fetchRandomQuote() async throws -> String {
        guard let url = URL(string: "https://zenquotes.io/api/random") else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let quotes = try decoder.decode([Quote].self, from: data)
            return quotes.first?.q ?? ""
        } catch {
            if error is URLError {
                throw NetworkError.invalidURL
            } else {
                throw NetworkError.decodingError
            }
        }
    }
}


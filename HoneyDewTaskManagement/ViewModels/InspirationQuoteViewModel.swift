//
//  InspirationQuoteViewModel.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 12/08/24.
//

import Foundation

class InspirationQuoteViewModel: ObservableObject {
    
    @Published var quote = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let service = InspirationQuoteService()
    
    func fetchQuote() async  {
       
            do {
                isLoading = true
                quote = try await service.fetchRandomQuote()
                errorMessage = ""
                print("in the service call block")
            } catch {
                switch error {
                case NetworkError.invalidURL:
                    errorMessage = "Invalid URL"
                case NetworkError.noDataReceived:
                    errorMessage = "No data received from the server"
                case NetworkError.decodingError:
                    errorMessage = "Failed to decode the response"
                case NetworkError.networkError(let urlError):
                      errorMessage = "Network error: \(urlError.localizedDescription)"
                default:
                    errorMessage = "An unknown error occurred"
                }
            } ; do {
                isLoading = false
            }
        }
    
}

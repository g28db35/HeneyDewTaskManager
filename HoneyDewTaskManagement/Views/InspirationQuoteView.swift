//
//  InspirationQuoteView.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 12/08/24.
//

import SwiftUI

struct InspirationQuoteView: View {
    @StateObject private var viewModel = InspirationQuoteViewModel()
    @State private var isAnimating = false
    var body: some View {
        VStack {
            /* Capstone requirement 4: text animation with .animation modifier*/
            Text("Your Daily Inspiration Quote")
                .font(.title)
                .foregroundColor(.blue)
                .opacity(isAnimating ? 1.0 : 0.0)
                .offset(y: isAnimating ? 0 : 50)
                .scaleEffect(isAnimating ? 1.0 : 0.5)
                .animation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.5), value: isAnimating)
                .onAppear {
                    withAnimation {
                        isAnimating = true
                    }
                }

            Text("\"\(viewModel.quote)\"")
                .font(.headline)
                .italic()
                .multilineTextAlignment(.center)
                .padding()
            
            if !viewModel.errorMessage.isEmpty {
                Text("Error: \(viewModel.errorMessage)")
                    .foregroundColor(.red)
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .padding()
        .task {
            await viewModel.fetchQuote();
        }
        
        
    }
}

#Preview {
    NavigationView {
        InspirationQuoteView()
    }
    .environmentObject(InspirationQuoteViewModel())
}

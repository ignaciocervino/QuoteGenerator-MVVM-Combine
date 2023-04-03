//
//  QuoteViewModel.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 01/04/2023.
//

import Foundation
import Combine

final class QuoteViewModel {
    private let quoteService: QuoteServicing
    private var cancellables = Set<AnyCancellable>()
    // MARK: Outputs
    let quoteResultPublisher: PassthroughSubject<Quote, Error>
    let toggleRefreshButtonPublisher: PassthroughSubject<Bool, Never>
    
    init(quoteService: QuoteServicing = QuoteService()) {
        self.quoteService = quoteService
        self.quoteResultPublisher = .init()
        self.toggleRefreshButtonPublisher = .init()
    }
}

// MARK: Inputs
extension QuoteViewModel: QuoteViewModelProtocol {
    func refreshButtonSelected() {
        handleGetRandomQuote()
    }
    
    func viewDidAppear() {
        handleGetRandomQuote()
    }
}

// MARK: Helper Functions
extension QuoteViewModel {
    private func handleGetRandomQuote() {
        quoteService.getRandomQuote().sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.quoteResultPublisher.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] quote in
            self?.quoteResultPublisher.send(quote)
        }
        .store(in: &cancellables)
    }
}

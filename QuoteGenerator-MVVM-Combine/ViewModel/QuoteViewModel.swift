//
//  QuoteViewModel.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 01/04/2023.
//

import Foundation
import Combine

private enum Constants {
    static let endpointURL = "https://api.quotable.io/random"
}

final class QuoteViewModel {
    // MARK: Propierties
    private let quoteService: QuoteServicing
    private var cancellables = Set<AnyCancellable>()
    private let quoteResultSubject: PassthroughSubject<Quote, Error>
    private let toggleRefreshButtonSubject: PassthroughSubject<Bool, Never>

    
    // MARK: Outputs
    var quoteResultPublisher: AnyPublisher<Quote, Error> {
        quoteResultSubject.eraseToAnyPublisher()
    }

    var toggleRefreshButtonPublisher: AnyPublisher<Bool, Never> {
        toggleRefreshButtonSubject.eraseToAnyPublisher()
    }

    // MARK: Initializer
    init(quoteService: QuoteServicing) {
        self.quoteService = quoteService
        self.quoteResultSubject = PassthroughSubject<Quote, Error>()
        self.toggleRefreshButtonSubject = PassthroughSubject<Bool, Never>()
    }
}

// MARK: - Inputs
extension QuoteViewModel: QuoteViewModelProtocol {
    func refreshButtonSelected() {
        toggleRefreshButton(isEnabled: false)
        handleGetRandomQuote()
    }
    
    func viewDidAppear() {
        toggleRefreshButton(isEnabled: false)
        handleGetRandomQuote()
    }
}

// MARK: - Helper Functions
extension QuoteViewModel {
    private func handleGetRandomQuote() {
        quoteService.getRandomQuote(from: Constants.endpointURL).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.quoteResultSubject.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] quote in
            self?.quoteResultSubject.send(quote)
            self?.toggleRefreshButton(isEnabled: true)
        }
        .store(in: &cancellables)
    }
    
    private func toggleRefreshButton(isEnabled: Bool) {
        toggleRefreshButtonSubject.send(isEnabled)
    }
}

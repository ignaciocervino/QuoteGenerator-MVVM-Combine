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
    let quoteResultPublisher: AnyPublisher<Quote, Error>
    let toggleRefreshButtonPublisher: AnyPublisher<Bool, Never>
    
    init(quoteService: QuoteServicing = QuoteService()) {
        self.quoteService = quoteService
    }
}

extension QuoteViewModel: QuoteViewModelProtocol {
    func refreshButtonSelected() {
        
    }
}

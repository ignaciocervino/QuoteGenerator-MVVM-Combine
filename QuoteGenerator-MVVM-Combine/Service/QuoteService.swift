//
//  QuoteService.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 01/04/2023.
//

import Foundation
import Combine

class QuoteService: QuoteServicing {
    func getRandomQuote(from endpointURL: String) -> AnyPublisher<Quote, Error> {
        guard let url = URL(string: endpointURL) else {
            return Fail(error: ServiceError.quoteServiceURLNotAvailable).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .map({ $0.data })
            .decode(type: Quote.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

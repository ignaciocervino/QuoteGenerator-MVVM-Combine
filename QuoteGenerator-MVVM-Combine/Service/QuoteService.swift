//
//  QuoteService.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 01/04/2023.
//

import Foundation
import Combine

private enum Constants {
    static let endpointURL = "https://api.quotable.io/random"
    static let domain = "ignacio.cervino.QuoteGenerator-MVVM-Combine"
    static let invalidURL = "Invalid URL"
}

class QuoteService: QuoteServicing {
    func getRandomQuote() -> AnyPublisher<Quote, Error> {
        guard let url = URL(string: Constants.endpointURL) else {
            let error = NSError(domain: Constants.domain, code: -1, userInfo: [NSLocalizedDescriptionKey: Constants.invalidURL])
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .map({ $0.data })
            .decode(type: Quote.self, decoder: JSONDecoder())
            .retry(2)
            .eraseToAnyPublisher()
    }
}

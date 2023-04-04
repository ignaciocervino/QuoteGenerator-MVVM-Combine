//
//  QuoteServicing.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 01/04/2023.
//

import Foundation
import Combine

protocol QuoteServicing {
    func getRandomQuote(from endpointURL: String) -> AnyPublisher<Quote, Error>
}

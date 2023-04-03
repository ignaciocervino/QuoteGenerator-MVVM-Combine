//
//  QuoteServiceMock.swift
//  QuoteGeneratorTests
//
//  Created by Ignacio Cervino on 03/04/2023.
//

@testable import QuoteGenerator_MVVM_Combine
import Combine

final class QuoteServiceMock: QuoteServicing {
    var value: AnyPublisher<Quote, Error>?
    
    func getRandomQuote() -> AnyPublisher<Quote, Error> {
        return value ?? Empty().eraseToAnyPublisher()
    }
}

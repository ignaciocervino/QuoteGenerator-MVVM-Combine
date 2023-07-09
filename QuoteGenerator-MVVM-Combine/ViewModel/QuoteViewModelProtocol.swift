//
//  QuoteViewModelProtocol.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 01/04/2023.
//

import Foundation
import Combine

protocol QuoteViewModelInputs {
    func refreshButtonSelected()
    func viewDidAppear()
}

protocol QuoteViewModelOutputs {
    var quoteResultPublisher: AnyPublisher<Quote, Error> { get }
    var toggleRefreshButtonPublisher: AnyPublisher<Bool, Never> { get }
}

protocol QuoteViewModelProtocol: QuoteViewModelInputs, QuoteViewModelOutputs {}

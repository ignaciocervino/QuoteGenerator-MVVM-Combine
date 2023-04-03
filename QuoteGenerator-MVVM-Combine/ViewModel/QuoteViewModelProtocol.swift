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
    var quoteResultPublisher: PassthroughSubject<Quote, Error> { get }
    var toggleRefreshButtonPublisher: PassthroughSubject<Bool, Never> { get }
}

protocol QuoteViewModelProtocol: QuoteViewModelInputs, QuoteViewModelOutputs {}

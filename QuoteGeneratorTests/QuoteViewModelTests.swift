//
//  QuoteGeneratorTests.swift
//  QuoteGeneratorTests
//
//  Created by Ignacio Cervino on 02/04/2023.
//

@testable import QuoteGenerator_MVVM_Combine
import XCTest
import Combine

class QuoteViewModelTests: XCTestCase {
    
    private var viewModel: QuoteViewModel!
    private var quoteServiceMock: QuoteServiceMock!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        quoteServiceMock = QuoteServiceMock()
        viewModel = QuoteViewModel(quoteService: quoteServiceMock)
    }
    
    override func tearDown() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
        viewModel = nil
        quoteServiceMock = nil
        super.tearDown()
    }
    
    func test_getRandomQuote_OnRefreshButtonTappedAndViewDidAppear_ShouldSucced() {
        // Given
        let expectation = XCTestExpectation(description: "recieved a quote")
        let quote = Quote(content: "Test quote", author: "Test author")
        quoteServiceMock.value = Just(quote)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        var isEnabled: Bool?
        viewModel.toggleRefreshButtonPublisher
            .sink { isEnabled = $0 }
            .store(in: &cancellables)
        
        var result: Quote?
        viewModel.quoteResultPublisher.sink { completion in
            if case .failure = completion {
                XCTFail("Expected to succeed but received failure")
            }
        } receiveValue: { quote in
            XCTAssertEqual(isEnabled, false, "Expected isEnabled to be false before getting a value.")
            expectation.fulfill()
            result = quote
        }
        .store(in: &cancellables)
        
        // When
        viewModel.refreshButtonSelected()
        
        // Then
        XCTAssertEqual(isEnabled, true, "Expected isEnabled to be true after refreshButtonSelected() was called successfully.")
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(result?.content, quote.content)
        XCTAssertEqual(result?.author, quote.author)
        XCTAssertEqual(cancellables.count, 2, "Expect cancellables for toggleRefreshButtonPublisher and quoteResultPublisher")
    }
    
    func test_getRandomQuote_OnRefreshButtonTappedAndViewDidAppear_ShouldFail() {
        // Given
        let error = NSError(domain: "Test failure", code: 0, userInfo: nil)
        quoteServiceMock.value = Fail(error: error)
            .eraseToAnyPublisher()
        var receivedError: Error?
        viewModel.quoteResultPublisher.sink { completion in
            if case .failure(let error) = completion {
                receivedError = error
            } else {
                XCTFail("Expected to receive failure but received success")
            }
        } receiveValue: { quote in
            XCTFail("Expected to receive failure but received quote: \(quote)")
        }
        .store(in: &cancellables)

        var isEnabled: Bool?
        viewModel.toggleRefreshButtonPublisher
            .sink { isEnabled = $0 }
            .store(in: &cancellables)
        
        // When
        viewModel.refreshButtonSelected()
        
        // Then
        XCTAssertEqual(receivedError as NSError?, error)
        XCTAssertEqual(isEnabled, false, "Expected isEnabled to be false after refreshButtonSelected() was called and failed to fetch quote.")
        XCTAssertEqual(cancellables.count, 2, "Expect cancellables for toggleRefreshButtonPublisher and quoteResultPublisher")
    }
}

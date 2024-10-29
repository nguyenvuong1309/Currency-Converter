//
//  HomeViewModelTest.swift
//  Currency Converter
//
//  Created by ducvuong on 27/10/24.
//

import XCTest
import Combine
@testable import Currency_Converter

class CurrencyConverterViewModelTest: XCTestCase {
    private var homeViewModel: CurrencyConverterViewModel!
    private var cancellable: AnyCancellable?
    private var filename = "NewsResponse"
    private let isloadingExpectation = XCTestExpectation(description: "isLoading true")
    
    override func setUp() {
        super.setUp()
        
        homeViewModel = CurrencyConverterViewModel()
    }
    
    override func tearDown() {
        homeViewModel = nil 
        
        super.tearDown()
    }
    
     func test_ready_State() {
        let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state ready",
                                      equals: [{ $0 == .ready}])
        wait(for: [expectation.expectation], timeout: 1)
    }
    
      func test_finished_State() {
         let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                       expectationDescription: "is state finished",
                                       equals: [{ $0 == .finished}])
         homeViewModel.serviceInitialize()
         wait(for: [expectation.expectation], timeout: 1)
     }
    
      func test_loading_State() {
         let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                       expectationDescription: "is state loading",
                                       equals: [{ $0 == .loading}])
         homeViewModel.serviceInitialize()
         wait(for: [expectation.expectation], timeout: 10)
     }
    
      func test_error_State() {
         filename = "error"
         setUp()
         let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                       expectationDescription: "is state error",
                                       equals: [{ $0 == .error(error: RequestError.invalidURL.customMessage)}])
         homeViewModel.serviceInitialize()
         wait(for: [expectation.expectation], timeout: 1)
     }
    
      func test_ShowingAlert() {
         filename = "error"
         setUp()
         homeViewModel.serviceInitialize()
        
         cancellable = homeViewModel.objectWillChange.eraseToAnyPublisher().sink { _ in
             XCTAssertEqual(self.homeViewModel.showingAlert, true)
             self.isloadingExpectation.fulfill()
         }
         wait(for: [isloadingExpectation], timeout: 10)
     }
    
      func test_empty_State() {
         let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                       expectationDescription: "is state empty",
                                       equals: [{ $0 == .empty}])
         homeViewModel.changeStateToEmpty()
         wait(for: [expectation.expectation], timeout: 1)
     }
    
      func test_news_Success() {
         let expectation = expectValue(of: homeViewModel.$exchangeRates.eraseToAnyPublisher(),
                                       expectationDescription: "Fetched News",
                                       equals: [{ $0 != [:]}])
         homeViewModel.serviceInitialize()
         wait(for: [expectation.expectation], timeout: 5)
     }
}

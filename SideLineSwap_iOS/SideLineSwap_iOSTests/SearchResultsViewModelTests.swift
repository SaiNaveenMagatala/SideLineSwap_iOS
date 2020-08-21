//
//  SearchResultsViewModelTests.swift
//  SideLineSwap_iOSTests
//
//  Created by Naveen Magatala on 8/21/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import Foundation
import XCTest

@testable import SideLineSwap_iOS

class SearchResultsViewModelTests: XCTestCase {
    var subject: SearchResultsViewModel!
    var fakeNetworkClient: FakeNetworkClient!
    
    override func setUp() {
        super.setUp()
        fakeNetworkClient = FakeNetworkClient()
        subject = SearchResultsViewModel(networkClient: fakeNetworkClient)
    }
    
    func testWhenGetItemsIsCalled() {
        // Given
        // When
        subject.getItems(searchString: "") { _ in }
        // Then
        XCTAssertTrue(fakeNetworkClient.isFetchCalled)
    }
    
    func testWhenFetchInProgress() {
        // Given
        subject.getItems(searchString: "") { _ in }
        XCTAssertTrue(fakeNetworkClient.isFetchCalled)
        // since the above call is in progress calling get items again should not make a new call
        fakeNetworkClient.isFetchCalled = false
        subject.getItems(searchString: "") { _ in }
        XCTAssertFalse(fakeNetworkClient.isFetchCalled)
        // when any of the calls are completed with sucess or failure
        fakeNetworkClient.fakeCompletion(.failure(.backendError))
        // it should make network call again
        let expectation = XCTestExpectation(description: "waiting for main thread async")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.2)
        subject.getItems(searchString: "") { _ in }
        XCTAssertTrue(fakeNetworkClient.isFetchCalled)
    }
    
    func testWhenAllExpectedResultsAreFetched() {
        // Given
        subject.data = (1...3).map { _ in CellModel(title: "", price: "", sellerName: "", imageUrl: "") }
        subject.total = 3
        // When
        subject.getItems(searchString: "") { _ in }
        // Then
        XCTAssertFalse(fakeNetworkClient.isFetchCalled)
    }
}

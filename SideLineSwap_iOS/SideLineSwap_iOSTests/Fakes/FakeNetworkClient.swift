//
//  FakeNetworkClient.swift
//  SideLineSwap_iOSTests
//
//  Created by Naveen Magatala on 8/21/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import Foundation

@testable import SideLineSwap_iOS

class FakeNetworkClient: NetworkClient {
    
    var isFetchCalled = false
    var fakeCompletion: ((Result<ItemResponseModel, SearchError>) -> Void)!
    
    func get(searchString: String,
             page: Int,
             completion: @escaping (Result<ItemResponseModel, SearchError>) -> Void) {
        isFetchCalled = true
        fakeCompletion = completion
    }
}

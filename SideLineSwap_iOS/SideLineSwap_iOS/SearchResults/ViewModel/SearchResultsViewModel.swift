//
//  SearchResultsViewModel.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/18/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import Foundation

class SearchResultsViewModel {
    private let networkClient: NetworkClient
    private var isFetching = false
    private var currentPage = 0
    var total = 0
    var data = [CellModel]()
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    convenience init() {
        self.init(networkClient: NetworkClientImpl())
    }
    
    func getItems(searchString: String, completion: @escaping (Result<[IndexPath], SearchError>) -> Void) {
        guard !isFetching, (data.count == 0 || data.count < total) else { return }
        isFetching = true
        self.currentPage += 1
        networkClient.get(searchString: searchString, page: currentPage) { result in
            switch result {
            case let .success(response):
                self.total = response.meta.paging.total
                let cellModels = response.data.map {
                    CellModel(title: $0.name,
                              price: "$" + $0.price.dropTrailingZeroes,
                              sellerName: $0.seller.badges.first?.name,
                              imageUrl: $0.images.first?.thumbUrl)
                }
                DispatchQueue.main.async {
                    let indexPathsToReload = self.calculateIndexPathsToReload(itemCount: cellModels.count)
                    self.isFetching = false
                    self.data.append(contentsOf: cellModels)
                    completion(.success(indexPathsToReload))
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.isFetching = false
                    completion(.failure(error))
                }
            }
        }
    }
    
    func resetData() {
        data = []
        currentPage = 0
        total = 0
    }
    
    private func calculateIndexPathsToReload(itemCount: Int) -> [IndexPath] {
        let start = data.count
        let end = start + itemCount
        return (start..<end).map { IndexPath(row: $0, section: 0) }
    }
}

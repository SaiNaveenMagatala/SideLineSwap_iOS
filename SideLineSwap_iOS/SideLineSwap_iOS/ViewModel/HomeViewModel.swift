//
//  HomeViewModel.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/18/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import Foundation

class HomeViewModel {
    // TODO: Inject and unit test?
    let networkClient = NetworkClient()
    private var isFetching = false
    private var currentPage = 0
    var total = 0
    var data = [CellModel]()
    
    func getItems(searchString: String, completion: @escaping ([IndexPath]) -> Void) {
        guard !isFetching else { return }
        isFetching = true
        print(currentPage)
        self.currentPage += 1
        networkClient.get(searchString: searchString, page: currentPage) { response in
            self.total = response.meta.paging.total
            print(self.total, "total")
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
                // calculate indexpaths to reload
                completion(indexPathsToReload)
            }
        }
    }
    
    func resetData() {
        data = []
        currentPage = 0
        total = 0
    }
    
    private func calculateIndexPathsToReload(itemCount: Int) -> [IndexPath] {
        let start = data.count // currentPage * 20
        let end = start + itemCount
        return (start..<end).map { IndexPath(row: $0, section: 0) }
    }
}

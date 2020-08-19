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
    
    func getItems(searchString: String, page: Int, completion: @escaping ([CellModel]) -> Void) {
        networkClient.get(searchString: searchString, page: page) { response in
            let cellModels = response.data.map {
                CellModel(title: $0.name,
                          price: $0.price.dropTrailingZeroes + "$",
                          sellerName: $0.seller.badges.first?.name,
                          imageUrl: $0.images.first?.thumbUrl)
            }
            
            completion(cellModels)
        }
    }
}

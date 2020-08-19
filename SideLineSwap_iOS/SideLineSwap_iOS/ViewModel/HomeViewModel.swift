//
//  HomeViewModel.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/18/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import Foundation

struct CellModel {
    let title: String
    let price: String
    let sellerName: String?
    let imageUrl: String?
}

class HomeViewModel {
    // TODO: Inject and unit test?
    let networkClient = NetworkClient()
    
    func getItems(completion: @escaping ([CellModel]) -> Void) {
        networkClient.get { response in
            let cellModels = response.data.map {
                CellModel(title: $0.name,
                          price: String($0.price),
                          sellerName: $0.seller.badges.first?.name,
                          imageUrl: $0.images.first?.thumbUrl)
            }
            
            completion(cellModels)
        }
    }
}

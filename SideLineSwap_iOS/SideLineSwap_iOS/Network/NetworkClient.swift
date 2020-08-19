//
//  NetworkClient.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/18/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import UIKit

class NetworkClient {
    // TODO: Error handling and clean up
    func get(completion: @escaping (ItemResponseModel) -> Void) {
        let urlStr = "https://api.staging.sidelineswap.com/v1/facet_items?q=nike%20bag&page=2"
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                if let model = try? jsonDecoder.decode(ItemResponseModel.self, from: data) {
                    completion(model)
                }
            }
        }.resume()
    }
}

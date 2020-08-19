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
    func get(searchString: String, page: Int, completion: @escaping (ItemResponseModel) -> Void) {
        let rawUrlStr = Constants.getItemsUrlStr
        let urlStr = String(format: rawUrlStr, searchString, page)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let sanitizedStr = urlStr, let url = URL(string: sanitizedStr) else { return }
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

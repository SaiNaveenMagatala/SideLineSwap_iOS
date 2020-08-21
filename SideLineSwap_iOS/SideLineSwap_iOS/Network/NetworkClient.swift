//
//  NetworkClient.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/18/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import UIKit

enum SearchError: Error {
    case disconnectedNetwork
    case backendError
}

protocol NetworkClient {
    func get(searchString: String,
             page: Int,
             completion: @escaping (Result<ItemResponseModel, SearchError>) -> Void)
}

class NetworkClientImpl: NetworkClient {
    func get(searchString: String,
             page: Int,
             completion: @escaping (Result<ItemResponseModel, SearchError>) -> Void) {
        let rawUrlStr = Constants.getItemsUrlStr
        let urlStr = String(format: rawUrlStr, searchString, page)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let sanitizedStr = urlStr, let url = URL(string: sanitizedStr) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                if let err = error as NSError? {
                    if err.code == Constants.disconnectedNetworkErrorCode {
                        completion(.failure(.disconnectedNetwork))
                        return
                    }
                }
                completion(.failure(.backendError))
                return
            }
            if let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let jsonDecoder = JSONDecoder()
                if let model = try? jsonDecoder.decode(ItemResponseModel.self, from: data) {
                    completion(.success(model))
                }
            } else {
                completion(.failure(.backendError))
                return
            }
        }.resume()
    }
}

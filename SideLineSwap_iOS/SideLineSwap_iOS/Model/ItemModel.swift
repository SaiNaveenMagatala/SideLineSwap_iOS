//
//  ItemModel.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/18/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import Foundation

struct ItemResponseModel: Decodable {
    let data: [ItemModel]
}

struct ItemModel: Decodable {

    let name: String
    let price: Double
    let images: [Image]
    let seller: Seller
    
    struct Image: Decodable {
        let thumbUrl: String
        
        enum CodingKeys: String, CodingKey {
            case thumbUrl = "thumb_url"
        }
    }
    
    struct Seller: Decodable {
        let badges: [Badge]
    }
    
    struct Badge: Decodable {
        let name: String
    }
}

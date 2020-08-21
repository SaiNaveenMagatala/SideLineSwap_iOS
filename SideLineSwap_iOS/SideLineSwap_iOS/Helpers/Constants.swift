//
//  Constants.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/19/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import UIKit

struct Constants {
    static let defaultMargin: CGFloat = 10
    static let numberOfCellsInRow: CGFloat = 2
    static let disconnectedNetworkErrorCode = -1009
    static let disconnectedNetworkText = "You appear to be offline.\nPlease check your network and try again"
    static let backendErrorText = "Ooops..! Something went wrong\nPlease try again later"
    static let placeHolderText = "What are you looking for?  eg: Nike bag"
    static let placeHolderImage = "placeHolder"
    static let getItemsUrlStr = "https://api.staging.sidelineswap.com/v1/facet_items?q=%@&page=%d"
}

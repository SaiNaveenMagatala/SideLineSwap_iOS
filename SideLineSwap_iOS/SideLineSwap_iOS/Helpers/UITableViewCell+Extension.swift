//
//  UITableViewCell+Extension.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/19/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func configure(with cellModel: CellModel,
                   tableView: UITableView,
                   indexPath: IndexPath,
                   cache: NSCache<NSString, UIImage>) {
        
        textLabel?.text = cellModel.title
        detailTextLabel?.text = cellModel.sellerName
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 25))
        label.text = cellModel.price
        accessoryView = label
        imageView?.setRoundedCornors()
        imageView?.setImage(with: cellModel.imageUrl, cache: cache)
    }
}

//
//  UIImageView+Extension.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/19/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(with urlStr: String?, cache: NSCache<NSString, UIImage>) {
        guard let urlStr = urlStr, let url = URL(string: urlStr) else { return }
        
        if let imageToSet = cache.object(forKey: NSString(string: urlStr)) {
            image = imageToSet
        } else {
            image = UIImage(named: Constants.placeHolderImage)
            DispatchQueue.global(qos: .background).async {
                let data = try! Data(contentsOf: url, options: .uncachedRead)
                if let imageToSet = UIImage(data: data) {
                    cache.setObject(imageToSet, forKey: NSString(string: urlStr))
                    DispatchQueue.main.async {
                        self.image = imageToSet
                    }
                }
            }
        }
    }
}

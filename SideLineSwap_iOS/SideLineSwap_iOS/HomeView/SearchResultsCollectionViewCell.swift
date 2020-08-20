//
//  SearchResultsCollectionViewCell.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/20/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import UIKit

class SearchResultsCollectionViewCell: UICollectionViewCell {
    
    private let itemImageView = UIImageView()
    private let priceLabel = UILabel()
    private let itemNameLabel = UILabel()
    private let sellerNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        backgroundColor = .white
        setShadow()
        
        itemImageView.addSubview(priceLabel)
        priceLabel.textColor = .white
        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.defaultMargin)
            make.bottom.equalToSuperview().inset(Constants.defaultMargin)
        }
        
        contentView.addSubview(itemImageView)
        itemImageView.clipsToBounds = true
        itemImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(itemImageView.snp.width)
        }
        
        contentView.addSubview(itemNameLabel)
        itemNameLabel.numberOfLines = 2
        itemNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        itemNameLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.leading.equalToSuperview().offset(Constants.defaultMargin)
        }
        
        contentView.addSubview(sellerNameLabel)
        sellerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(2)
            make.trailing.equalToSuperview().inset(5)
            make.leading.equalToSuperview().offset(Constants.defaultMargin)
        }
        sellerNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    private func setShadow() {
        itemImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        itemImageView.layer.cornerRadius = 5
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }
    
    func configure(with cellModel: CellModel,
                   cache: NSCache<NSString, UIImage>) {
        itemNameLabel.text = cellModel.title
        sellerNameLabel.text = cellModel.sellerName
        priceLabel.text = cellModel.price
        itemImageView.setImage(with: cellModel.imageUrl, cache: cache)
    }
}

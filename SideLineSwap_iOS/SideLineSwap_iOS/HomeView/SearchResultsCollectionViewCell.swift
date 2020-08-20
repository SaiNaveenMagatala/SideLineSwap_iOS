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
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        itemImageView.addSubview(priceLabel)
        
        itemImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(10)
        }
        
        containerStackView.addArrangedSubview(itemImageView)
        containerStackView.addArrangedSubview(itemNameLabel)
        containerStackView.addArrangedSubview(sellerNameLabel)
        
        contentView.addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with cellModel: CellModel,
                   cache: NSCache<NSString, UIImage>) {
        itemNameLabel.text = cellModel.title
        sellerNameLabel.text = cellModel.sellerName
        priceLabel.text = cellModel.price
        itemImageView.setImage(with: cellModel.imageUrl, cache: cache)
    }
}

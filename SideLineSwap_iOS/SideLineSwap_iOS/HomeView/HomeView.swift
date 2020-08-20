//
//  HomeView.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/18/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    lazy var collectionViewLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    let searchBar = UISearchBar()
    private let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        backgroundColor = UIColor.white.withAlphaComponent(0.95)
        
        loadingIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(searchBar)
        searchBar.placeholder = Constants.placeHolderText
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    func showLoadingIndicator() {
        alpha = 0.7
        loadingIndicator.startAnimating()
        loadingIndicator.backgroundColor = .white
    }
    
    func hideLoadingIndicator() {
        alpha = 1
        loadingIndicator.stopAnimating()
        loadingIndicator.hidesWhenStopped = true
    }
    
}

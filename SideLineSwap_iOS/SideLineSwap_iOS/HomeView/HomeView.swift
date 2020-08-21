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
    
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    private lazy var collectionViewLayout = UICollectionViewFlowLayout()
    private let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    // MARK: Error
    private let errorImageView = UIImageView()
    private let errorMessageLabel = UILabel()
    private let errorView = UIView()
    
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
        
        addSubview(errorView)
        errorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.defaultMargin)
            make.trailing.equalToSuperview().inset(Constants.defaultMargin)
            make.height.equalTo(220)
        }
        errorView.addSubview(errorImageView)
        errorImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.centerX.equalToSuperview()
        }
        
        errorView.addSubview(errorMessageLabel)
        errorMessageLabel.numberOfLines = 2
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(errorImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        errorView.isHidden = true
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
    
    func configure(for error: SearchError) {
        collectionView.isHidden = true
        errorView.isHidden = false
        switch error {
        case .disconnectedNetwork:
            errorImageView.image = #imageLiteral(resourceName: "disconnectedNetwork")
            errorMessageLabel.text = Constants.disconnectedNetworkText
        case .backendError:
            errorImageView.image = #imageLiteral(resourceName: "warning")
            errorMessageLabel.text = Constants.backendErrorText
        }
    }
    
    func configureForSucess() {
        errorView.isHidden = true
        collectionView.isHidden = false
    }
    
    func configureCollectionView(with vc: HomeViewController) {
        collectionView.dataSource = vc
        collectionView.delegate = vc
        collectionView.register(SearchResultsCollectionViewCell.self,
                                         forCellWithReuseIdentifier: "SearchResultsCollectionViewCell.self")
    }
}

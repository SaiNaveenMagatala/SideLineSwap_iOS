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
    
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    private let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        backgroundColor = .systemGray
        
        tableView.rowHeight = Constants.rowHeight
        addSubview(tableView)
        tableView.tableHeaderView = searchController.searchBar
        
        loadingIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin)
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

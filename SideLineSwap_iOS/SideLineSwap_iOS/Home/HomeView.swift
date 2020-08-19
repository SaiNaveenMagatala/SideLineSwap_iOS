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
    private let searchController = UISearchController(searchResultsController: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        backgroundColor = .white
        
        tableView.rowHeight = 50
        addSubview(tableView)
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

//
//  HomeViewController.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/18/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let rootView = HomeView()
    private let viewModel = HomeViewModel()
    private var data = [CellModel]()
    private let cache = NSCache<NSString, UIImage>()
    
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Results"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell.self")
        
        viewModel.getItems { cellModels in
            self.data = cellModels
            DispatchQueue.main.async {
                self.rootView.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell.self")
        cell.selectionStyle = .none
        cell.configure(with: data[indexPath.row], tableView: tableView, indexPath: indexPath, cache: cache)
        return cell
    }
    
    
}


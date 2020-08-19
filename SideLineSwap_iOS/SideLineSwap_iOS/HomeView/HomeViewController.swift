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
        
        rootView.searchController.searchBar.delegate = self
    }
    
    private func resetData() {
        data = []
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

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetData()
        rootView.tableView.reloadData()
        rootView.searchController.dismiss(animated: true, completion: nil)
        rootView.showLoadingIndicator()
        if let searchString = searchBar.text {
            viewModel.getItems(searchString: searchString, page: 1) { cellModels in
                self.data = cellModels
                DispatchQueue.main.async {
                    self.rootView.hideLoadingIndicator()
                    self.rootView.tableView.reloadData()
                }
            }
        }
    }
}


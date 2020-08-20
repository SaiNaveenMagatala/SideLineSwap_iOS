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
    private let cache = NSCache<NSString, UIImage>()
    private var searchString = ""
    
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Results"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        rootView.tableView.dataSource = self
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell.self")
        
        rootView.searchController.searchBar.delegate = self
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell.self")
        cell.selectionStyle = .none
        if indexPath.row < viewModel.data.count {
            cell.configure(with: viewModel.data[indexPath.row],
                           tableView: tableView,
                           indexPath: indexPath,
                           cache: cache)
        }
        
        if indexPath.row == viewModel.data.count - 10 {
            viewModel.getItems(searchString: searchString) { result in
                switch result {
                case let .success(indexPathsToInsert):
                    self.rootView.tableView.insertRows(at: indexPathsToInsert, with: .automatic)
                case .failure:
                    break
                }
            }
        }
        return cell
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        rootView.searchController.dismiss(animated: true, completion: nil)
        if let searchString = searchBar.text, searchString != self.searchString {
            self.searchString = searchString
            viewModel.resetData()
            rootView.tableView.reloadData()
            rootView.showLoadingIndicator()
            viewModel.getItems(searchString: searchString) { _ in
                self.rootView.hideLoadingIndicator()
                self.rootView.tableView.reloadData()
            }
        }
    }
}


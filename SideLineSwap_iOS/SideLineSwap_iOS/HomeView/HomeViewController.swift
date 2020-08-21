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
        
        rootView.configureCollectionView(with: self)
        
        rootView.searchBar.delegate = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "SearchResultsCollectionViewCell.self",
                                 for: indexPath) as? SearchResultsCollectionViewCell else { fatalError() }
        if indexPath.row < viewModel.data.count {
            cell.configure(with: viewModel.data[indexPath.row],
                           cache: cache)
        }
        
        if indexPath.row == viewModel.data.count - 10 {
            viewModel.getItems(searchString: searchString) { result in
                switch result {
                case let .success(indexPathsToInsert):
                    self.rootView.collectionView.insertItems(at: indexPathsToInsert)
                case .failure:
                    break
                }
            }
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width
        let padding = Constants.defaultMargin * 3
        let width = (viewWidth - padding) / Constants.numberOfCellsInRow
        return CGSize(width: width, height: width + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.defaultMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: Constants.defaultMargin, bottom: 0, right: Constants.defaultMargin)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        rootView.searchBar.resignFirstResponder()
        rootView.searchBar.setShowsCancelButton(false, animated: true)
        if let searchString = searchBar.text, searchString != self.searchString {
            viewModel.resetData()
            rootView.collectionView.reloadData()
            rootView.showLoadingIndicator()
            viewModel.getItems(searchString: searchString) { result in
                self.rootView.hideLoadingIndicator()
                switch result {
                case .success:
                    self.searchString = searchString
                    self.rootView.configureForSucess()
                    self.rootView.collectionView.reloadData()
                case let .failure(error):
                    self.rootView.configure(for: error)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        rootView.searchBar.resignFirstResponder()
        rootView.searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.rootView.searchBar.setShowsCancelButton(true, animated: true)
    }
}


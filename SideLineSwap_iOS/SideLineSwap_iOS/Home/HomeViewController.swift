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
    
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.tableView.dataSource = self
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell.self")
        
        viewModel.getItems { cellModels in
            self.data = cellModels
            DispatchQueue.main.async {
                self.rootView.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell.self")
        cell.configure(with: data[indexPath.row], tableView: tableView, indexPath: indexPath)
        return cell
    }
}

extension UITableViewCell {
    func configure(with cellModel: CellModel, tableView: UITableView, indexPath: IndexPath) {
        textLabel?.text = cellModel.title
        detailTextLabel?.text = cellModel.sellerName
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        label.text = cellModel.price
        accessoryView = label
        // TODO: Handle image fetching
        DispatchQueue.global(qos: .background).async {
            if let urlStr = cellModel.imageUrl, let url = URL(string: urlStr) {
                let data = try! Data(contentsOf: url, options: .mappedRead)
                DispatchQueue.main.async {
                    self.imageView?.image = UIImage(data: data)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
}


//
//  ViewController.swift
//  iOSRecruitmentTest
//
//  Created by Bazyli Zygan on 15.06.2016.
//  Copyright © 2016 Snowdog. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class RecruitmentItemListViewController: UIViewController, ShowsAlert {
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    private var initialContentOffset = CGPoint()
    fileprivate let refreshControl = UIRefreshControl()

    var viewModel: RecruitmentItemListViewModel!
    weak var delegate: RecruitmentItemListCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfiguration()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.fetch()
        viewModel.filteredRecruitmentItems.bind(to: self) { strongSelf, _ in
            strongSelf.tableView.reloadData()
            strongSelf.refreshControl.endRefreshing()
        }
        searchBarTextField.reactive.text.bind(to: viewModel.searchString)
    }
}

extension RecruitmentItemListViewController: UITableViewDataSource, UITableViewDelegate {
    
    static let tableViewCellIdentifier = "TableViewCell"
    
    fileprivate func tableViewConfiguration() {
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.initialContentOffset = self.tableView.contentOffset
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: RecruitmentItemListViewController.tableViewCellIdentifier)
    }
    
    @objc func refresh(sender:AnyObject) {
        viewModel.fetch()
    }
    
    // MARK: - UITableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredRecruitmentItems.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        if let model = viewModel.filteredRecruitmentItems.value {
            cell.item = model[indexPath.row]
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected item at \(indexPath)")
        if let model = viewModel.filteredRecruitmentItems.value {
            delegate?.startItemDetails(with: model[indexPath.row])
        }
    }
}

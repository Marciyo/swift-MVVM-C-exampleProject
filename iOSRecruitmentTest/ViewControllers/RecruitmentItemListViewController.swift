//
//  ViewController.swift
//  iOSRecruitmentTest
//
//  Created by Bazyli Zygan on 15.06.2016.
//  Copyright © 2016 Snowdog. All rights reserved.
//

import UIKit
import Bond

class RecruitmentItemListViewController: UIViewController, ShowsAlert {
    @IBOutlet weak var searchBar: UISearchBar!
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
        viewModel.recruitmentItems.bind(to: self) { strongSelf, _ in
            strongSelf.tableView.reloadData()
            strongSelf.refreshControl.endRefreshing()
        }

//        searchController.searchBar.rx.text.asObservable()
//            .map { ($0 ?? "").lowercased() }
//            .map { UniversityRequest(name: $0) }
//            .flatMap { request -> Observable<[UniversityModel]> in
//                return self.apiClient.send(apiRequest: request)
//            }
//            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
//                cell.textLabel?.text = model.name
//            }
    }
}


extension RecruitmentItemListViewController: UITableViewDataSource {
    
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
        return viewModel.recruitmentItems.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        if let model = viewModel.recruitmentItems.value {
            cell.item = model[indexPath.row]
        }
        return cell
    }
}

// TODO: IN RX BINDING SEARCHBAR TO FILTEREDCONTENT
//extension RecruitmentItemListViewController:  UISearchBarDelegate{
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.filterContentForSearchText(searchText)
//    }
//}


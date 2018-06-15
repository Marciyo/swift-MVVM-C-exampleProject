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
        self.tableViewConfiguration()
        bindViewModel()

        viewModel.fetch()
        
            //On Completion after fetch\/
//            DispatchQueue.main.async(execute: { [weak self] () -> Void in
////                self?.imageCacheAssistant.clearCache()
//                self?.tableView.reloadData()
//                self?.refreshControl.endRefreshing()
//                if let text = self?.searchBar.text {
//                    self?.filterContentForSearchText(text)
//                }
//            })
            // or on error
            /* DispatchQueue.main.async(execute: { [weak self] () -> Void in
                self?.refreshControl.endRefreshing()
                self?.showAlert(message: "Couldn't fetch data from the server")
                if let initialOffset = self?.initialContentOffset{
                    self?.tableView.setContentOffset(initialOffset, animated: true)
                }
            })*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//        self.imageCacheAssistant.clearCache()
    }
    
    private func bindViewModel() {
        
    }
}


extension RecruitmentItemListViewController: UITableViewDataSource {
    
    static let tableViewCellIdentifier = "TableViewCell"
    
    fileprivate func tableViewConfiguration() {
//        self.refreshControl.addTarget(self, action: #selector(viewModel.fetch), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        self.initialContentOffset = self.tableView.contentOffset
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: RecruitmentItemListViewController.tableViewCellIdentifier)
    }
    
    // MARK: - UITableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsEmpty() {
            return viewModel.recruitmentItems.value!.count
        }
        return viewModel.filteredRecruitmentItemsEntityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        let model: RecruitmentItemEntity
        
//        if self.searchBarIsEmpty() {
        model = viewModel.recruitmentItemsEntityData[indexPath.row]
//        } else {
//            model = self.filteredRecruitmentItemsEntityData[indexPath.row]
//        }
        
        
        
        cell.item = model
//        if let image = self.imageCacheAssistant.getImage(for: model.iconUrl ?? "") {
//            cell.iconView.image = image
//        } else {
//            ImageDownloader.downloadedFrom(link: model.iconUrl ?? "", completion: { [weak self] image in
//                DispatchQueue.main.async(execute: { [weak self] () -> Void in
//                    self?.imageCacheAssistant.setImage(image: image, forKey: model.iconUrl ?? "")
//                    if let cell = self?.tableView.cellForRow(at: indexPath) as? TableViewCell {
//                        cell.iconView.image = image
//                    }
//                })
//            })
//        }
        return cell
    }
}

extension RecruitmentItemListViewController:  UISearchBarDelegate{
    private func searchBarIsEmpty() -> Bool {
        return self.searchBar.text?.isEmpty ?? true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterContentForSearchText(searchText)
    }
}


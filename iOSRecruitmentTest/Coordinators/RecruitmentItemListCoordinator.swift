//
//  ItemListCoordinator.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

protocol RecruitmentItemListCoordinatorDelegate: class {
    func open(url: String)
    func startItemDetails()
}

class RecruitmentItemListCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    let rootViewController: UINavigationController
    var application = UIApplication.shared
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.childCoordinators = []
    }
    
    func start() {
        let recruitmentItemListVC: RecruitmentItemListViewController = RecruitmentItemListViewController()
        recruitmentItemListVC.viewModel = RecruitmentItemListViewModel()
        recruitmentItemListVC.title = "RecruitmentItems"
        recruitmentItemListVC.delegate = self
        rootViewController.pushViewController(recruitmentItemListVC, animated: true)
    }
}

extension RecruitmentItemListCoordinator: RecruitmentItemListCoordinatorDelegate {
    func open(url: String) {
        guard let url = URL(string: url) else { return }
        application.open(url, options: [:], completionHandler: nil)
    }
    
    func startItemDetails() {
        let itemDetailsVC = RecruitmentItemDetailsViewController()
        itemDetailsVC.title = "ItemDetails"
        itemDetailsVC.viewModel = RecruitmentItemDetailsViewModel()
        rootViewController.pushViewController(itemDetailsVC, animated: true)
    }

}

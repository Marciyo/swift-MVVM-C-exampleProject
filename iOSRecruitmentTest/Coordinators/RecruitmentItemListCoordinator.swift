//
//  ItemListCoordinator.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

protocol RecruitmentItemListCoordinatorDelegate: class {
    func startItemDetails()
}

final class RecruitmentItemListCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator]
    var application = UIApplication.shared
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.childCoordinators = []
    }
    
    func start() {
        let recruitmentItemListVC = RecruitmentItemListViewController()
        recruitmentItemListVC.viewModel = RecruitmentItemListViewModel()
        recruitmentItemListVC.delegate = self
        rootViewController.pushViewController(recruitmentItemListVC, animated: true)
    }
}

extension RecruitmentItemListCoordinator: RecruitmentItemListCoordinatorDelegate {
    func startItemDetails() {
        let itemDetailsVC = RecruitmentItemDetailsViewController()
        itemDetailsVC.viewModel = RecruitmentItemDetailsViewModel()
        rootViewController.pushViewController(itemDetailsVC, animated: true)
    }
}

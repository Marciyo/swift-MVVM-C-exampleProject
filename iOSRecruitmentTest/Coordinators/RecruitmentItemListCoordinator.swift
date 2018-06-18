//
//  ItemListCoordinator.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

protocol RecruitmentItemListCoordinatorDelegate: class {
    func startItemDetails(with model: RecruitmentItemModel)
}

final class RecruitmentItemListCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator]
    
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
    func startItemDetails(with model: RecruitmentItemModel) {
        let itemDetailsVC = RecruitmentItemDetailsViewController()
        let viewModel = RecruitmentItemDetailsViewModel(model)
        itemDetailsVC.viewModel = viewModel
        itemDetailsVC.delegate = self
        rootViewController.pushViewController(itemDetailsVC, animated: true)
    }
}

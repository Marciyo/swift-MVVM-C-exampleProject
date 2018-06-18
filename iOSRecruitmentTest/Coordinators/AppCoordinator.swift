//
//  AppCoordinator.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator]
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        rootViewController = UINavigationController()
        self.childCoordinators = []
        self.window = window
        window.rootViewController = navigationController
    }
    
    func start() {
        let recruitmentItemListCoordinator = RecruitmentItemListCoordinator(rootViewController: navigationController)
        recruitmentItemListCoordinator.start()
        add(childCoordinator: recruitmentItemListCoordinator)
    }
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
}

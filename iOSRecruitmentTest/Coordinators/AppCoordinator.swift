//
//  AppCoordinator.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

class AppCoordinator: ModuleCoordinator {
    func start() {
        let recruitmentItemListCoordinator = RecruitmentItemListCoordinator(rootViewController: navigationController)
        let recruitmentItemListVC = RecruitmentItemListViewController()
        recruitmentItemListVC.delegate = recruitmentItemListCoordinator
        recruitmentItemListCoordinator.start()
        add(childCoordinator: recruitmentItemListCoordinator)
        window.rootViewController = recruitmentItemListVC
    }
    
    
    var childCoordinators: [Coordinator]
    
    private let window: UIWindow
    private let userDefaults = UserDefaults.standard
    
    private var appStarted: Bool {
        set { userDefaults.set(newValue, forKey: Constants.UserDefaultsKeys.appStarted) }
        get { return userDefaults.object(forKey: Constants.UserDefaultsKeys.appStarted) as? Bool ?? false }
    }
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.childCoordinators = []
        self.window = window
    }
}

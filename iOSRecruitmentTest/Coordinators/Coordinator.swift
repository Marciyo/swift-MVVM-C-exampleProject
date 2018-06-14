//
//  Coordinator.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func add(childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    func remove(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
    func removeChildCoordinator<T: Coordinator>(type: T.Type) {
        self.childCoordinators.forEach {
            if let coordinator = $0 as? T {
                self.remove(childCoordinator: coordinator)
            }
        }
    }
}

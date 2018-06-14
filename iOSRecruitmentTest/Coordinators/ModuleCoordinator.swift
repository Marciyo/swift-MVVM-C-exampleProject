//
//  ModuleCoordinator.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

enum ModuleType: String {
    case recruitmentItemsList
}

struct Module: Decodable {
    let type: String
    let title: String
    let icon: String
    let params: [String]?
    let childs: [Module]?
}

protocol ModuleCoordinator: Coordinator {}

extension ModuleCoordinator {
    func coordinator(for module: Module, rootViewController: UINavigationController) -> Coordinator {
        guard let moduleType = ModuleType(rawValue: module.type) else {
            fatalError("Couldn't init coordinator for module type: \(module.type)")
        }
        
        switch moduleType {
        case .recruitmentItemsList: return RecruitmentItemListCoordinator(rootViewController: rootViewController)
        }
    }
}

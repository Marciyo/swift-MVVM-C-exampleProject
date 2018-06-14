//
//  RecruitmentItemListManager.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

typealias RecruitmentItemListCompletion = (Result<RecruitmentItemModel>) -> Void

protocol RecruitmentItemListManager {
    func fetch(completion: @escaping RecruitmentItemListCompletion)
}

class LocalRecruitmentItemListManager: RecruitmentItemListManager {

    func fetch(completion: @escaping RecruitmentItemListCompletion) {
        let about = RecruitmentItemModel.init(id: 1, name: "blabla", description: "blabla", icon: "bla", timestamp: 2, url: "bla")
        completion(.success(about))
    }
}

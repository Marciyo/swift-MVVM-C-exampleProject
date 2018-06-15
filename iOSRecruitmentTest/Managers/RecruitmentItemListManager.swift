//
//  RecruitmentItemListManager.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

typealias RecruitmentItemListCompletion = (Result<[RecruitmentItemModel]>) -> Void

protocol RecruitmentItemListManager {
    func fetch(completion: @escaping RecruitmentItemListCompletion)
}

class LocalRecruitmentItemListManager: RecruitmentItemListManager {
    
    private let service = RecruitmentItemService()

    func fetch(completion: @escaping RecruitmentItemListCompletion) {
        var items: [RecruitmentItemModel] = []
        service.fetchData(successHandler: { (response) in
            items = response
            completion(.success(items))
        }) {
            print("error is following")
        }
    }
}

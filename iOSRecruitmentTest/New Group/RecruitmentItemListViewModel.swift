//
//  RecruitmentItemListViewModel.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 14/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import ReactiveKit
import Bond

class RecruitmentItemListViewModel {
    
    private let recruitmentItemListManager = LocalRecruitmentItemListManager()
    let recruitmentItem = Observable<RecruitmentItemModel?>(nil)

    let refreshing = Observable<Bool>(false)
    private(set) var error: Error?
    
    func fetch() {
        refreshing.value = true
        recruitmentItemListManager.fetch { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.refreshing.value = false
            strongSelf.error = result.error
            
            guard let model = result.value else { return }
            strongSelf.recruitmentItem.value = model
        }
    }
}

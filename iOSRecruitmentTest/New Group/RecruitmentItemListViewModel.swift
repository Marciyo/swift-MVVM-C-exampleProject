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
    
    let refreshing = Observable<Bool>(false)
    let recruitmentItems = Observable<[RecruitmentItemModel]?>(nil)
    let filteredRecruitmentItems = Observable<[RecruitmentItemModel]?>(nil)

    private(set) var error: Error?
    

    func fetch() {
        refreshing.value = true
        recruitmentItemListManager.fetch { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.refreshing.value = false
            strongSelf.error = result.error
            
            guard let model = result.value else { return }
            strongSelf.recruitmentItems.value = model
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRecruitmentItems.value = recruitmentItems.value?.filter({( item : RecruitmentItemModel) -> Bool in
                return item.name.lowercased().contains(searchText.lowercased())
        })
    }
}

//    PersistenceService.deleteAll()
//
//    private let imageCacheAssistant = ImageCacheAssistant()
//    private let recruitmentItemsFetcher = RecruitmentItemsFetcher()
//    var recruitmentItemsEntityData: [RecruitmentItemEntity] = []
//        self.recruitmentItemsEntityData = self.recruitmentItemsFetcher.fetchRecruitmentItemsFromCore().sorted(by: { $0.id < $1.id })

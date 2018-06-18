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
    let searchString = Observable<String?>("")

    private(set) var error: Error?
    
    init() {
        searchString.value = ""
        _ = searchString
            .filter { $0 != "" }
            .observeNext { [weak self] text in
                if let text = text {
                    self?.filterContentForSearchText(text)
                }
        }
    }

    func fetch() {
        refreshing.value = true
        PersistenceService.deleteAll()
        recruitmentItemListManager.fetch { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.refreshing.value = false
            strongSelf.error = result.error
            
            guard let model = result.value else { return }
            strongSelf.recruitmentItems.value = model
            if strongSelf.filteredRecruitmentItems.value == nil {
                strongSelf.filteredRecruitmentItems.value = model
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredRecruitmentItems.value = recruitmentItems.value?.filter({( item : RecruitmentItemModel) -> Bool in
            return item.name.lowercased().contains(searchText.lowercased())
        })
    }
}

//
//    private let imageCacheAssistant = ImageCacheAssistant()
//    private let recruitmentItemsFetcher = RecruitmentItemsFetcher()
//    var recruitmentItemsEntityData: [RecruitmentItemEntity] = []
//    self.recruitmentItemsEntityData = self.recruitmentItemsFetcher.fetchRecruitmentItemsFromCore().sorted(by: { $0.id < $1.id })

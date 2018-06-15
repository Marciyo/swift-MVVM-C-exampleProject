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
    
    private let imageCacheAssistant = ImageCacheAssistant()
    
    var recruitmentItemsEntityData: [RecruitmentItemEntity] = []
    var filteredRecruitmentItemsEntityData: [RecruitmentItemEntity] = []
    private let recruitmentItemsFetcher = RecruitmentItemsFetcher()
    
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
        filteredRecruitmentItemsEntityData = recruitmentItemsEntityData.filter({( item : RecruitmentItemEntity) -> Bool in
            if let name = item.name{
                return name.lowercased().contains(searchText.lowercased())
            }else {
                return false
            }
        })
    }
    //        self.recruitmentItemsEntityData = self.recruitmentItemsFetcher.fetchRecruitmentItemsFromCore().sorted(by: { $0.id < $1.id })

}

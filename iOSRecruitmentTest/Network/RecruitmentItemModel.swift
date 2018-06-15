//
//  RecruitmentItemModel.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 3/24/18.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

struct RecruitmentItemModel: Decodable{
    let id: Int
    let name: String
    let description: String
    let icon: String
    let timestamp: Int
    let url: String
}

extension RecruitmentItemModel {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case icon = "icon"
        case timestamp = "timestamp"
        case url = "url"
    }
}

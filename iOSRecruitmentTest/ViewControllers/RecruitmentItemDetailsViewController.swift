//
//  ItemDetailsViewController.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 13/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

class RecruitmentItemDetailsViewController: UIViewController, ShowsAlert {
    
    var viewModel: RecruitmentItemDetailsViewModel!
    weak var delegate: RecruitmentItemListCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func back(sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
}

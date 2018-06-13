//
//  Extensions.swift
//  iOSRecruitmentTest
//
//  Created by Marcel Mierzejewski on 13/06/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import UIKit

extension UIView {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

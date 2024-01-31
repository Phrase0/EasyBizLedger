//
//  AddItemViewModel.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/29.
//

import UIKit

class AddItemViewModel {
    
    var doneTitle: String
    var clearTitle: String
    var doneColor: UIColor
    var clearColor: UIColor
    var doneBackgroundColor: UIColor
    var clearBackgroundColor: UIColor
    var categoryTitleLabel: String
    var categoryTitleColor: UIColor

    init(doneTitle: String, clearTitle: String, doneColor: UIColor, clearColor: UIColor, doneBackgroundColor: UIColor, clearBackgroundColor: UIColor, categoryTitleLabel: String, categoryTitleColor: UIColor) {
        self.doneTitle = doneTitle
        self.clearTitle = clearTitle
        self.doneColor = doneColor
        self.clearColor = clearColor
        self.doneBackgroundColor = doneBackgroundColor
        self.clearBackgroundColor = clearBackgroundColor
        self.categoryTitleLabel = categoryTitleLabel
        self.categoryTitleColor = categoryTitleColor
    }
}

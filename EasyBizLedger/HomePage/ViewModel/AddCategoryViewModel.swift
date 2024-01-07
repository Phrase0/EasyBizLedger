//
//  AddCategoryViewModel.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/7.
//

import UIKit

class AddCategoryViewModel {
    
    var doneTitle: String
    var cancelTitle: String
    var doneColor: UIColor
    var cancelColor: UIColor
    var doneBackgroundColor: UIColor
    var cancelBackgroundColor: UIColor
    var categoryTitleLabel: String
    var categoryTitleColor: UIColor

    init(doneTitle: String, cancelTitle: String, doneColor: UIColor, cancelColor: UIColor, doneBackgroundColor: UIColor, cancelBackgroundColor: UIColor, categoryTitleLabel: String, categoryTitleColor: UIColor) {
        self.doneTitle = doneTitle
        self.cancelTitle = cancelTitle
        self.doneColor = doneColor
        self.cancelColor = cancelColor
        self.doneBackgroundColor = doneBackgroundColor
        self.cancelBackgroundColor = cancelBackgroundColor
        self.categoryTitleLabel = categoryTitleLabel
        self.categoryTitleColor = categoryTitleColor
    }
}

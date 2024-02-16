//
//  HomeViewModel.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/6.
//

import UIKit

class HomeViewModel {
    
    var title: String
    var color: UIColor
    var imageName: String
    
    init(title: String, color: UIColor, imageName: String) {
        self.title = title
        self.color = color
        self.imageName = imageName
    }
}

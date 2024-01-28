//
//  HomeModel.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/7.
//

import UIKit

struct HomeModel {
    
}

struct Category: Hashable {
    let identifier: UUID
    var title: String

    init(title: String) {
        self.identifier = UUID()
        self.title = title
    }
}

struct Item: Hashable {
    var nameLabel: String
    var priceLabel: Int
    var stockLabel: Int
    var photo: UIImage
}

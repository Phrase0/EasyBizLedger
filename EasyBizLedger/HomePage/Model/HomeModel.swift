//
//  HomeModel.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/7.
//

import UIKit

struct HomeModel {
    
}
enum Category {
    case item
}

struct Item: Hashable {
    var nameLabel: String
    var priceLabel: Int
    var stockLabel: Int
    var photo: UIImage
}

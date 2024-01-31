//
//  AddItemModel.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/29.
//

import UIKit

enum AddItemSection {
    case main
}

struct AddItemData: Hashable {
    let identifier: UUID
    var categoryLabel: String
    var itemLabel: String
    var priceLabel: Int
    var stockLabel: Int
    var photo: UIImage
    
    init(categoryLabel: String, titleLabel: String, priceLabel: Int, stockLabel: Int, photo: UIImage) {
        self.identifier = UUID()
        self.categoryLabel = categoryLabel
        self.itemLabel = titleLabel
        self.priceLabel = priceLabel
        self.stockLabel = stockLabel
        self.photo = photo
    }
}

enum ShowList: String, CaseIterable {
    case photo
    case category
    case item
    case price
    case amount
}

//
//  ClearableTextFieldCell.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/2/6.
//

import UIKit

protocol ClearableTextFieldCell: AnyObject {
    var textField: UITextField { get }
    func clearTextField()
}

extension ClearableTextFieldCell {
    func clearTextField() {
        textField.text = ""
    }
}

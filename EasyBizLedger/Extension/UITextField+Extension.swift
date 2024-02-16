//
//  UITextField+Extension.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/2/3.
//

import UIKit

extension UITextField {
    func loadDropdownData(data: [String]) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self)
    }

    func loadDropdownData(data: [String], onSelect selectionHandler: @escaping (String) -> Void) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self, onSelect: selectionHandler)
    }
}

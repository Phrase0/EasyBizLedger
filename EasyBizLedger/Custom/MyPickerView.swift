//
//  MyPickerView.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/2/3.
//

import UIKit
 
class MyPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickerData: [String]!
    var pickerTextField: UITextField!
    var selectionHandler: ((String) -> Void)?

    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: CGRect.zero)

        self.pickerData = pickerData
        self.pickerTextField = dropdownField

        self.delegate = self
        self.dataSource = self

        DispatchQueue.main.async {
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }

        if let text = self.pickerTextField.text, let handler = self.selectionHandler {
            handler(text)
        }
    }

    init(pickerData: [String], dropdownField: UITextField, onSelect selectionHandler: @escaping (String) -> Void) {
        self.selectionHandler = selectionHandler

        super.init(frame: CGRect.zero)

        self.pickerData = pickerData
        self.pickerTextField = dropdownField

        self.delegate = self
        self.dataSource = self

        DispatchQueue.main.async {
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }

        if let text = self.pickerTextField.text, let handler = self.selectionHandler {
            handler(text)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    // When the user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]

        if let text = self.pickerTextField.text, let handler = self.selectionHandler {
            handler(text)
        }
    }
}

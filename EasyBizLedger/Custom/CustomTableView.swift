//
//  CustomTableView.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/27.
//

import UIKit

class CustomTableView: UITableView {
    
    init(
        rowHeight: CGFloat,
        separatorStyle: UITableViewCell.SeparatorStyle,
        allowsSelection: Bool,
        registerCells: [UITableViewCell.Type]
    ) {
        super.init(frame: .zero, style: .insetGrouped)
        self.rowHeight = rowHeight
        self.separatorStyle = separatorStyle
        self.allowsSelection = allowsSelection
        for cellClass in registerCells {
            self.registerCell(cellClass)
        }
        // self.backgroundColor = .systemGray5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

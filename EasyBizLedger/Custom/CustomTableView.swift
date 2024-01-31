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
        registerCells: [UITableViewCell.Type],
        style: UITableView.Style,
        backgroundColor: UIColor?
    ) {
        super.init(frame: .zero, style: style)
        self.rowHeight = rowHeight
        self.separatorStyle = separatorStyle
        self.allowsSelection = allowsSelection
        for cellClass in registerCells {
            self.registerCell(cellClass)
        }
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

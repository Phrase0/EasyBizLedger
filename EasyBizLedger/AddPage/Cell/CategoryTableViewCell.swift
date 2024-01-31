//
//  CategoryTableViewCell.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/30.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "\(CategoryTableViewCell.self)"

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Category"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var textFieldBackgroundView = {
        let textFieldBackgroundView = UIView()
        textFieldBackgroundView.layer.cornerRadius = 10
        textFieldBackgroundView.backgroundColor = .white
        textFieldBackgroundView.layer.shadowColor = UIColor.black.cgColor
        textFieldBackgroundView.layer.shadowOpacity = 0.2
        textFieldBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        textFieldBackgroundView.layer.shadowRadius = 4
        return textFieldBackgroundView
    }()
    
    lazy var categoryTextField = {
        let textField = UITextField()
        return textField
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
        categoryLabel.sizeToFit()
        textFieldBackgroundView.sizeToFit()
        categoryTextField.sizeToFit()
    }
    
    override func prepareForReuse() {
        categoryLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Auto layout
    private func setupCellUI() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(textFieldBackgroundView)
        textFieldBackgroundView.addSubview(categoryTextField)
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.centerY.equalTo(textFieldBackgroundView)
        }
        
        textFieldBackgroundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(categoryLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-45)
            make.height.equalTo(40).priority(999)
            make.width.greaterThanOrEqualTo(40)
        }
        
        categoryTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
}

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
        textFieldBackgroundView.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: .lightGray)
        textFieldBackgroundView.layer.shadowColor = UIColor.setColor(lightColor: .black, darkColor: .white).cgColor
        textFieldBackgroundView.layer.shadowOpacity = 0.2
        textFieldBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        textFieldBackgroundView.layer.shadowRadius = 4
        return textFieldBackgroundView
    }()
    
    lazy var categoryTextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .default
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
        categoryTextField.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Auto layout
    private func setupCellUI() {
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(categoryLabel)
        contentView.addSubview(textFieldBackgroundView)
        textFieldBackgroundView.addSubview(categoryTextField)
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.centerY.equalTo(textFieldBackgroundView)
        }
        
        textFieldBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(categoryLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-45)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(40).priority(999)
            make.width.equalTo(190)
        }
        
        categoryTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
}

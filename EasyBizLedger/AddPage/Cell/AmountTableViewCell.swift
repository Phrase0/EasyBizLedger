//
//  AmountTableViewCell.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/31.
//

import UIKit

class AmountTableViewCell: UITableViewCell {

    static let identifier = "\(AmountTableViewCell.self)"

    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Amount"
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
    
    lazy var amountTextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        return textField
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
        amountLabel.sizeToFit()
        textFieldBackgroundView.sizeToFit()
        amountTextField.sizeToFit()
    }
    
    override func prepareForReuse() {
        amountTextField.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Auto layout
    private func setupCellUI() {
        //contentView.backgroundColor = .systemGray6
        contentView.addSubview(amountLabel)
        contentView.addSubview(textFieldBackgroundView)
        textFieldBackgroundView.addSubview(amountTextField)
        
        amountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.centerY.equalTo(textFieldBackgroundView)
        }
        
        textFieldBackgroundView.snp.makeConstraints { make in
            make.leading.equalTo(amountLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-45)
            make.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
}

//
//  HomeTableViewCell.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "\(HomeTableViewCell.self)"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stockLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var photoImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        return photoImageView
    }()
    
    lazy var addButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        // button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.lightGray
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var subButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        // button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.lightGray
        button.addTarget(self, action: #selector(subButtonTapped), for: .touchUpInside)
        return button
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
    
    lazy var numberTextField = {
        let numberTextField = UITextField()
        numberTextField.placeholder = "0"
        numberTextField.textAlignment = .center
        numberTextField.keyboardType = .numberPad
        return numberTextField
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        stockLabel.sizeToFit()
        photoImageView.sizeToFit()
        addButton.sizeToFit()
        subButton.sizeToFit()
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        priceLabel.text = nil
        stockLabel.text = nil
        photoImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Auto layout
    private func setupCellUI() {
        
        contentView.backgroundColor = UIColor.setColor(lightColor: .systemGray6, darkColor: .black)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(stockLabel)
        contentView.addSubview(photoImageView)
        contentView.addSubview(addButton)
        contentView.addSubview(subButton)
        contentView.addSubview(textFieldBackgroundView)
        textFieldBackgroundView.addSubview(numberTextField)
        
        photoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(photoImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(photoImageView.snp_trailingMargin).offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(15)
            make.leading.equalTo(photoImageView.snp_trailingMargin).offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        stockLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp_bottomMargin).offset(15)
            make.leading.equalTo(photoImageView.snp_trailingMargin).offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(30)
        }
        
        subButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(30)
        }
        
        textFieldBackgroundView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalTo(subButton.snp_trailingMargin).offset(15)
            make.trailing.equalTo(addButton.snp_leadingMargin).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        
        numberTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
    @objc private func addButtonTapped() {
    }
    
    @objc private func subButtonTapped() {
    }
}

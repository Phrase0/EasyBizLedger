//
//  AddItemTableViewCell.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/29.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let identifier = "\(PhotoTableViewCell.self)"
    
    lazy var photoImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.image = UIImage(imageLiteralResourceName: "demo")
        return photoImageView
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Category"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stockLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
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
        itemLabel.sizeToFit()
        priceLabel.sizeToFit()
        stockLabel.sizeToFit()
        photoImageView.sizeToFit()
    }
    
    override func prepareForReuse() {
        itemLabel.text = nil
        priceLabel.text = nil
        stockLabel.text = nil
        photoImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Auto layout
    private func setupCellUI() {
        contentView.addSubview(photoImageView)
//        contentView.addSubview(categoryLabel)
//        contentView.addSubview(itemLabel)
        //        contentView.addSubview(priceLabel)
        //        contentView.addSubview(stockLabel)
//        contentView.addSubview(textFieldBackgroundView)
//        textFieldBackgroundView.addSubview(categoryTextField)
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(photoImageView.snp.height)
        }
        
//        categoryLabel.snp.makeConstraints { make in
//            make.top.equalTo(photoImageView.snp.bottom).offset(30)
//            make.leading.equalToSuperview().offset(45)
//        }
//
//        textFieldBackgroundView.snp.makeConstraints { make in
//            make.top.equalTo(photoImageView.snp.bottom).offset(20)
//            make.leading.equalTo(categoryLabel.snp.trailing).offset(15)
//            make.trailing.equalToSuperview().offset(-45)
//            make.height.equalTo(40)
//            make.width.greaterThanOrEqualTo(40)
//            make.bottom.lessThanOrEqualToSuperview().offset(-20)
//        }
//
//        categoryTextField.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        //        itemLabel.snp.makeConstraints { make in
        //            make.top.equalToSuperview().offset(15)
        //            make.leading.equalTo(photoImageView.snp_trailingMargin).offset(15)
        //        }
        //
        //
        //        priceLabel.snp.makeConstraints { make in
        //            make.top.equalTo(itemLabel.snp_bottomMargin).offset(15)
        //            make.leading.equalTo(photoImageView.snp_trailingMargin).offset(15)
        //            make.trailing.equalToSuperview().offset(-100)
        //        }
        //
        //        stockLabel.snp.makeConstraints { make in
        //            make.top.equalTo(priceLabel.snp_bottomMargin).offset(15)
        //            make.leading.equalTo(photoImageView.snp_trailingMargin).offset(15)
        //            make.bottom.equalToSuperview().offset(-15)
        //            make.trailing.equalToSuperview().offset(-100)
        //        }
        //
        //        textFieldBackgroundView.snp.makeConstraints { make in
        //            make.bottom.equalToSuperview().offset(-15)
        //            make.leading.equalTo(subButton.snp_trailingMargin).offset(15)
        //            make.trailing.equalTo(addButton.snp_leadingMargin).offset(-15)
        //            make.height.equalTo(30)
        //            make.width.equalTo(60)
        //        }
        //
        
        
        
    }



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
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        stockLabel.sizeToFit()
        photoImageView.sizeToFit()
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

        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(15)
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

    }
    
}

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
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
        photoImageView.sizeToFit()
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Auto layout
    private func setupCellUI() {
        contentView.addSubview(photoImageView)
        contentView.backgroundColor = .systemGray6
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(photoImageView.snp.height)
        }
    }
}

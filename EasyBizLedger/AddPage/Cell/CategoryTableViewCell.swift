//
//  CategoryTableViewCell.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/30.
//

import UIKit

//protocol CategoryTableViewCellDelegate: AnyObject {
//    func categoryButtonUpdated()
//}

class CategoryTableViewCell: UITableViewCell {
    
    static let identifier = "\(CategoryTableViewCell.self)"
    
    let lsCategorys = LocalStorageManager.shared.categorys
    
    // weak var delegate: CategoryTableViewCellDelegate?
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Category"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textFieldBackgroundView = {
        let textFieldBackgroundView = UIView()
        textFieldBackgroundView.layer.cornerRadius = 10
        textFieldBackgroundView.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: .lightGray)
        textFieldBackgroundView.layer.shadowColor = UIColor.labelColor.cgColor
        textFieldBackgroundView.layer.shadowOpacity = 0.2
        textFieldBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        textFieldBackgroundView.layer.shadowRadius = 4
        return textFieldBackgroundView
    }()
    
    lazy var categoryTextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        let categoryData = lsCategorys.compactMap { $0.title }
        textField.loadDropdownData(data: categoryData)
        return textField
    }()
    
    //    lazy var categoryButton: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.tintColor = UIColor.labelColor
    //        // set pop up button
    //        button.showsMenuAsPrimaryAction = true
    //        button.changesSelectionAsPrimaryAction = true
    //        let lsCategorys = LocalStorageManager.shared.categorys
    //        guard !lsCategorys.isEmpty else {
    //            categoryButton.isEnabled = false
    //            return button
    //        }
    //        let menuItems: [UIAction] = lsCategorys.map { category in
    //            return UIAction(title: category.title!, handler: { [weak self] action in
    //                print(category.title)
    //            })
    //        }
    //        let menu = UIMenu(children: menuItems)
    //        categoryButton.menu = menu
    //        categoryButton.isEnabled = true
    //        return button
    //    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
        categoryLabel.sizeToFit()
        textFieldBackgroundView.sizeToFit()
        categoryTextField.sizeToFit()
        //categoryButton.sizeToFit()
    }
    
    override func prepareForReuse() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Auto layout
    private func setupCellUI() {
        // contentView.backgroundColor = .systemGray6
        contentView.addSubview(categoryLabel)
        contentView.addSubview(textFieldBackgroundView)
        textFieldBackgroundView.addSubview(categoryTextField)
        //textFieldBackgroundView.addSubview(categoryButton)
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.centerY.equalTo(textFieldBackgroundView)
        }
        
        textFieldBackgroundView.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-45)
            make.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        categoryTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        //        categoryButton.snp.makeConstraints { make in
        //            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        //        }
    }
    
}

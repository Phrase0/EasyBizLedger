//
//  AddViewController.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2023/12/26.
//

import UIKit

class AddItemViewController: UIViewController {
    
    private var doneButton = UIButton(type: .custom)
    private var clearButton = UIButton(type: .custom)
    
    private lazy var addItemViewModel: AddItemViewModel = {
        return AddItemViewModel(
            doneTitle: NSLocalizedString("AddVC.done", comment: ""),
            clearTitle: NSLocalizedString("Clear", comment: ""),
            doneColor: UIColor.black,
            clearColor: UIColor.black,
            doneBackgroundColor: UIColor.lightGray,
            clearBackgroundColor: UIColor.lightGray,
            categoryTitleLabel: NSLocalizedString("AddVC.categoryTitleLabel", comment: ""),
            categoryTitleColor: UIColor.black)
    }()
    
    private lazy var addItemTableView: CustomTableView = {
        return  CustomTableView(
            rowHeight: UITableView.automaticDimension,
            separatorStyle: .none,
            allowsSelection: false,
            registerCells: [
                PhotoTableViewCell.self,
                CategoryTableViewCell.self,
                ItemTableViewCell.self,
                PriceTableViewCell.self,
                AmountTableViewCell.self],
            style: .plain,
            backgroundColor: .systemGray6)
    }()
    
    var snapshot = NSDiffableDataSourceSnapshot<AddItemSection, String>()
    var dataSource: UITableViewDiffableDataSource<AddItemSection, String>!
    private let showListArray = ShowList.allCases.map { $0.rawValue }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addItemTableView)
        addItemTableView.delegate = self
        setupUI()
        configureDataSource()
        applySnapshot()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAutolayout()
    }
    
    private func setupUI() {
        // backgroundColor
        view.backgroundColor = .baseBackgroundColor
        
        // doneButton
        doneButton.setTitle(addItemViewModel.doneTitle, for: .normal)
        doneButton.setTitleColor(addItemViewModel.doneColor, for: .normal)
        doneButton.backgroundColor = addItemViewModel.doneBackgroundColor
        doneButton.layer.cornerRadius = 10
        doneButton.layer.masksToBounds = true
        doneButton.configuration = .bordered()
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        // set button size
        doneButton.sizeToFit()
        // create a UIBarButtonItem
        let doneBarButtonItem = UIBarButtonItem(customView: doneButton)
        navigationItem.rightBarButtonItem = doneBarButtonItem
        
        // cancelButton
        clearButton.setTitle(addItemViewModel.clearTitle, for: .normal)
        clearButton.setTitleColor(addItemViewModel.clearColor, for: .normal)
        clearButton.setTitleColor(addItemViewModel.clearColor, for: .highlighted)
        clearButton.backgroundColor = addItemViewModel.clearBackgroundColor
        clearButton.layer.cornerRadius = 10
        clearButton.layer.masksToBounds = true
        clearButton.configuration = .bordered()
        clearButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        // set button size
        clearButton.sizeToFit()
        // create a UIBarButtonItem
        let cancelBarButtonItem = UIBarButtonItem(customView: clearButton)
        navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
    
    private func setupAutolayout() {
        // set addItemTableView
        addItemTableView.snp.makeConstraints { make in
            
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    @objc private func doneButtonTapped() {
    }
    
    @objc private func cancelButtonTapped() {
    }
}

extension AddItemViewController: UITableViewDelegate {
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<AddItemSection, String>(
            tableView: addItemTableView,
            cellProvider: { tableView, indexPath, item in
                switch indexPath.row {
                case 0:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else {
                        return UITableViewCell()
                    }
                    return cell

                case 1:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                        return UITableViewCell()
                    }
                    return cell

                case 2:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
                        return UITableViewCell()
                    }
                    return cell

                case 3:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.identifier, for: indexPath) as? PriceTableViewCell else {
                        return UITableViewCell()
                    }
                    return cell

                case 4:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: AmountTableViewCell.identifier, for: indexPath) as? AmountTableViewCell else {
                        return UITableViewCell()
                    }
                    return cell

                default:
                    return UITableViewCell()
                }
            }
        )
    }

    
    private func applySnapshot() {

        let categoriesInSection1 = [
            AddItemData(categoryLabel: "類別", titleLabel: "名稱", priceLabel: 1, stockLabel: 3, photo: UIImage(imageLiteralResourceName: "demo"))
        ]
        let categoriesInSection2 = [
            AddItemData(categoryLabel: "類別", titleLabel: "名稱", priceLabel: 1, stockLabel: 3, photo: UIImage(imageLiteralResourceName: "demo"))
        ]
        
        // clean snapShot
        snapshot = NSDiffableDataSourceSnapshot<AddItemSection, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(showListArray, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

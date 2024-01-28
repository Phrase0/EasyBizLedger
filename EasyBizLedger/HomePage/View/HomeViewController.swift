//
//  HomeViewController.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2023/12/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    // create UIButton
    let addButton = UIButton(type: .custom)
    
    private lazy var homeViewModel: HomeViewModel = {
        return HomeViewModel(
            title: NSLocalizedString("HomeVC.addCategory", comment: ""),
            color: UIColor.systemBlue,
            imageName: "plus")
    }()
    
    private lazy var homeTableView: CustomTableView = {
        return  CustomTableView(
            rowHeight: UITableView.automaticDimension,
            separatorStyle: .singleLine,
            allowsSelection: true,
            registerCells: [HomeTableViewCell.self])
    }()
    
    var snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
    var dataSource: UITableViewDiffableDataSource<Category, Item>!
    var sectionNames:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        view.addSubview(homeTableView)
        setupUI()
        configureDataSource()
        //applySnapshot()
        applySnapshot2()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAutolayout()
    }
    
    private func setupUI() {
        
        // backgroundColor
        view.backgroundColor = .baseBackgroundColor
        
        // addButton
        addButton.setTitle(homeViewModel.title, for: .normal)
        addButton.setTitleColor(homeViewModel.color, for: .normal)
        addButton.setImage(UIImage(systemName: homeViewModel.imageName), for: .normal)
        addButton.imageView?.contentMode = .scaleAspectFit
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        // set button size
        addButton.sizeToFit()
        
        // create a UIBarButtonItem
        let addBarButtonItem = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = addBarButtonItem
        
    }
    
    private func setupAutolayout() {
        // set homeTableView
        homeTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func addButtonTapped() {
        let addCategoryViewController = AddCategoryViewController()
        addCategoryViewController.delegate = self
        addCategoryViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addCategoryViewController, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let category = snapshot.sectionIdentifiers[section]
        // add titleLabel
        let titleLabel = UILabel()
        titleLabel.text = category.title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerView.addSubview(titleLabel)
        
        // add editButton
        let editButton = UIButton(type: .system)
        let editImage = UIImage(systemName: "square.and.pencil")
        editButton.setImage(editImage, for: .normal)
        editButton.tintColor = UIColor.gray
        editButton.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(editButton)
        
        // add deleteButton
        let deleteButton = UIButton(type: .system)
        let deleteImage = UIImage(systemName: "trash")
        deleteButton.setImage(deleteImage, for: .normal)
        deleteButton.tintColor = UIColor.gray
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(deleteButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        editButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp_trailingMargin).offset(20)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    // Edit button
    @objc func editButtonTapped(_ sender: UIButton) {
        let addCategoryViewController = AddCategoryViewController()
        addCategoryViewController.delegate = self
        addCategoryViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addCategoryViewController, animated: true)
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        let section = sender.tag
        
        // delete sectionNames's title
        guard section < sectionNames.count else {
            return
        }
        
        let categoryName = sectionNames[section]
        sectionNames.remove(at: section)

        // delete corresponding section from snapshot
        var currentSnapshot = dataSource.snapshot()
        if let deletedSection = currentSnapshot.sectionIdentifiers.first(where: { $0.title == categoryName }) {
            currentSnapshot.deleteSections([deletedSection])
            // update snapshot
            dataSource.apply(currentSnapshot, animatingDifferences: false)
        }
        
    }
    // ---------------------------------------------------
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Category, Item>(
            tableView: homeTableView,
            cellProvider: { tableView, indexPath, category in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.nameLabel.text = category.nameLabel
                cell.priceLabel.text = "Price: \(category.priceLabel)"
                cell.stockLabel.text = "Stock: \(category.stockLabel)"
                cell.photoImageView.image = category.photo
                cell.contentView.backgroundColor = .baseBackgroundColor
                cell.selectionStyle = .none
                return cell
            }
        )
    }
    
    private func applySnapshot() {
        // 創建兩個假的 Category
        let categoriesInSection1 = [
            Item(nameLabel: "Item 1", priceLabel: 10, stockLabel: 20, photo: UIImage(imageLiteralResourceName: "demo")),
            Item(nameLabel: "Item 2", priceLabel: 15, stockLabel: 25, photo: UIImage(imageLiteralResourceName: "demo"))
        ]
        let categoriesInSection2 = [
            Item(nameLabel: "Item 1", priceLabel: 10, stockLabel: 20, photo: UIImage(imageLiteralResourceName: "demo")),
            Item(nameLabel: "Item 2", priceLabel: 15, stockLabel: 25, photo: UIImage(imageLiteralResourceName: "demo")),
            Item(nameLabel: "Item 3", priceLabel: 20, stockLabel: 30, photo: UIImage(imageLiteralResourceName: "demo"))
        ]
        
        // Apply fake data to the snapshot
        let newSection1 = Category(title: "文具")
        snapshot.appendSections([newSection1])
        snapshot.appendItems(categoriesInSection1, toSection: newSection1)
        
        let newSection2 = Category(title: "衣物")
        snapshot.appendSections([newSection2])
        snapshot.appendItems(categoriesInSection2, toSection: newSection2)
        
        // Apply the snapshot to the dataSource
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    // ---------------------------------------------------
    func applySnapshot2() {
        
        // clean snapShot
        snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
        for sectionName in sectionNames {
            let newSection = Category(title: sectionName)
            // 為每個 sectionName 增加 section
            snapshot.appendSections([newSection])
            
            let categoriesInSection1 = [
                Item(nameLabel: "Item 1", priceLabel: 10, stockLabel: 20, photo: UIImage(imageLiteralResourceName: "demo")),
                Item(nameLabel: "Item 2", priceLabel: 15, stockLabel: 25, photo: UIImage(imageLiteralResourceName: "demo"))
            ]
            
            snapshot.appendItems(categoriesInSection1, toSection: newSection)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension HomeViewController: AddCategoryViewControllerDelegate {
    func addCategoryViewControllerDidFinish(with categoryName: String) {
        sectionNames.append(categoryName)
        applySnapshot2()
    }
    
}

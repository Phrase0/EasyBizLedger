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
    var sectionTag:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        view.addSubview(homeTableView)
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
        addCategoryViewController.originatingPage = 1
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
        editButton.tag = section
        headerView.addSubview(editButton)
        
        // add deleteButton
        let deleteButton = UIButton(type: .system)
        let deleteImage = UIImage(systemName: "trash")
        deleteButton.setImage(deleteImage, for: .normal)
        deleteButton.tintColor = UIColor.gray
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        deleteButton.tag = section
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
        sectionTag = sender.tag
        let addCategoryViewController = AddCategoryViewController()
        addCategoryViewController.delegate = self
        addCategoryViewController.originatingPage = 2
        addCategoryViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addCategoryViewController, animated: true)
        
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        sectionTag = sender.tag
        guard let sectionTag = sectionTag, sectionTag < sectionNames.count else { return }
        // let categoryName = sectionNames[section]
        sectionNames.remove(at: sectionTag)
        applySnapshot()
    }
    // if let deletedCategory = dataSource.snapshot().sectionIdentifiers.first(where: { $0.title == categoryName }) {
    //    let deletedCategory = self.snapshot.sectionIdentifiers[section].identifier
    //    let deletedTitle = self.snapshot.sectionIdentifiers[section].title
    // self.snapshot.deleteSections([Category(identifier: deletedCategory, title: deletedTitle)])
    
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
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

extension HomeViewController: AddCategoryViewControllerDelegate {
    func editCategoryViewControllerDidFinish(with categoryName: String) {
        guard let sectionTag = sectionTag, sectionTag < sectionNames.count else { return }
        sectionNames[sectionTag] = categoryName
        applySnapshot()
        
    }
    
    func addCategoryViewControllerDidFinish(with categoryName: String) {
        sectionNames.append(categoryName)
        applySnapshot()
    }
    
}

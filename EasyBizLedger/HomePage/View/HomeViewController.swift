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
            allowsSelection: false,
            registerCells: [HomeTableViewCell.self],
            style: .insetGrouped,
            backgroundColor: .systemGray6)
    }()
    
    var snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
    var dataSource: UITableViewDiffableDataSource<Category, Item>!
    
    static var sectionNames:[String] = []
    var sectionTag: Int?
    
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
            make.trailing.equalToSuperview().offset(-10)
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
        guard let sectionTag = sectionTag, sectionTag < HomeViewController.sectionNames.count else { return }
        let addCategoryViewController = AddCategoryViewController()
        addCategoryViewController.delegate = self
        addCategoryViewController.originatingPage = 2
        addCategoryViewController.originCategoryName = HomeViewController.sectionNames[sectionTag]
        addCategoryViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addCategoryViewController, animated: true)
        
    }
    
    // delete Button
    @objc func deleteButtonTapped(_ sender: UIButton) {
        sectionTag = sender.tag
        print("delete:\(sectionTag)")
        guard let sectionTag = sectionTag, sectionTag < HomeViewController.sectionNames.count else { return }

        let sectionName = HomeViewController.sectionNames[sectionTag]
        // add alert
        let alertController = UIAlertController(
            title: "Warning",
            message: "Are you sure to delete?",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let deleteAction = UIAlertAction(title: "delete", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            // delete section
            HomeViewController.sectionNames.remove(at: sectionTag)
            
            self.applySnapshot()
        }
        alertController.addAction(deleteAction)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alertController, animated: true, completion: nil)
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
                return cell
            }
        )
    }
    
    private func applySnapshot() {
        // clean snapShot
        snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
        for sectionName in HomeViewController.sectionNames {
            let newSection = Category(title: sectionName)
            // 為每個 sectionName 增加 section
            snapshot.appendSections([newSection])
            
            let categoriesInSection1 = [
                Item(nameLabel: "Item 1", priceLabel: 10, stockLabel: 10, photo: UIImage(imageLiteralResourceName: "demo")),
                Item(nameLabel: "Item 2", priceLabel: 15, stockLabel: 25, photo: UIImage(imageLiteralResourceName: "demo"))
            ]
            
            snapshot.appendItems(categoriesInSection1, toSection: newSection)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
  
}

extension HomeViewController: AddCategoryViewControllerDelegate {
    func editCategoryViewControllerDidFinish(with categoryName: String) {
        guard let sectionTag = sectionTag, sectionTag < HomeViewController.sectionNames.count else { return }
        HomeViewController.sectionNames[sectionTag] = categoryName
        applySnapshot()
        
    }
    
    func addCategoryViewControllerDidFinish(with categoryName: String) {
        HomeViewController.sectionNames.append(categoryName)
        applySnapshot()
    }
    
}

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
            registerCells: [HomeTableViewCell.self],
            style: .insetGrouped,
            backgroundColor: .systemGray6)
    }()
    
    var snapshot = NSDiffableDataSourceSnapshot<LSCategory, LSItem>()
    var dataSource: UITableViewDiffableDataSource<LSCategory, LSItem>!
    
    var lsCategorys = LocalStorageManager.shared.categorys
    var sectionTag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        view.addSubview(homeTableView)
        setupUI()
        configureDataSource()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        print("Selected section header: \(section)")
        let category = snapshot.sectionIdentifiers[section]
        // add titleLabel
        let titleLabel = UILabel()
        titleLabel.text = category.title
        titleLabel.textColor = UIColor.setColor(lightColor: .darkGray, darkColor: .white)
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
        guard let sectionTag = sectionTag, sectionTag < lsCategorys.count else { return }
        
        let addCategoryViewController = AddCategoryViewController()
        addCategoryViewController.delegate = self
        addCategoryViewController.originatingPage = 2
        
        let selectedCategoryTitle = lsCategorys[sectionTag].title
        addCategoryViewController.originCategoryName = selectedCategoryTitle
        
        addCategoryViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addCategoryViewController, animated: true)
    }
    
    // delete Button
    @objc func deleteButtonTapped(_ sender: UIButton) {
        let sectionTag = sender.tag
        print(sectionTag)
        guard sectionTag < lsCategorys.count else { return }
        let categoryToDelete = lsCategorys[sectionTag]
        
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
            LocalStorageManager.shared.deleteCategory(categoryToDelete) { [weak self] result in
                switch result {
                case .success:
                    guard var snapshot = self?.dataSource?.snapshot() else {return}
                    snapshot.deleteSections([categoryToDelete])
                    self?.dataSource?.apply(snapshot, animatingDifferences: false)
                case .failure(let error):
                    print("Failed to delete category: \(error)")
                }
            }
        }
        alertController.addAction(deleteAction)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<LSCategory, LSItem>(
            tableView: homeTableView,
            cellProvider: { tableView, indexPath, category in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.nameLabel.text = category.itemName
                cell.priceLabel.text = "Price: \(category.price)"
                cell.stockLabel.text = "Stock: \(category.amount)"
                // cell.photoImageView.image = category.photo
                cell.contentView.backgroundColor = .baseBackgroundColor
                return cell
            }
        )
    }
    
    private func applySnapshot() {
        // clean snapShot
        snapshot = NSDiffableDataSourceSnapshot<LSCategory, LSItem>()
        
        for category in lsCategorys {
            
            // add section
            snapshot.appendSections([category])
            
            let itemsInSection = category.lSItems?.allObjects as? [LSItem] ?? []
            snapshot.appendItems(itemsInSection, toSection: category)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
}

// MARK: - AddCategoryViewControllerDelegate
extension HomeViewController: AddCategoryViewControllerDelegate {
    
    func editCategoryViewControllerDidFinish(with categoryName: String) {
        guard let sectionTag = sectionTag, sectionTag < lsCategorys.count else { return }
        
        let lsCategory = lsCategorys[sectionTag]
        lsCategory.title = categoryName
        
        // 保存更新
        LocalStorageManager.shared.save { [weak self] result in
            switch result {
            case .success:
                self?.fetchCategoryNamesAndUpdateSnapshot()
            case .failure(let error):
                print("Failed to save edited category: \(error)")
            }
        }
    }
    
    func addCategoryViewControllerDidFinish(with categoryName: String) {
        // store new one into Core Data
        LocalStorageManager.shared.saveCategory(title: categoryName) { [weak self] result in
            switch result {
            case .success:
                // update categorys array
                self?.fetchCategoryNamesAndUpdateSnapshot()
            case .failure(let error):
                print("Failed to add category: \(error)")
            }
        }
    }
    
    private func fetchCategoryNamesAndUpdateSnapshot() {
        // get Core Data from new data
        LocalStorageManager.shared.fetchCategorys { [weak self] result in
            switch result {
            case .success(let categorys):
                // update categorys array
                self?.lsCategorys = categorys
                self?.applySnapshot()
            case .failure(let error):
                print("Failed to fetch category names: \(error)")
            }
        }
    }
    
}

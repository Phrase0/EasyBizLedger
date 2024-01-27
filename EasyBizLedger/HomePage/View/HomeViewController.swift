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
    
    private var snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
    private var dataSource: UITableViewDiffableDataSource<Category, Item>!
    
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
    
    // ---------------------------------------------------
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Category, Item>(
            tableView: homeTableView,
            cellProvider: { tableView, indexPath, category in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
                    return UITableViewCell()
                }
                
                // 設定 HomeTableViewCell 的元素
                cell.nameLabel.text = category.nameLabel
                cell.priceLabel.text = "Price: \(category.priceLabel)"
                cell.stockLabel.text = "Stock: \(category.stockLabel)"
                cell.photo.text = "Photo: \(category.photo)" // 假設這裡使用 UILabel 顯示圖片名稱
                
                return cell
            }
        )
    }
    
    private func applySnapshot() {
        // 創建三個假的 Category
        let categoriesInSection1 = [
            Item(nameLabel: "Category 1", priceLabel: 10, stockLabel: 20, photo: "photo1"),
            Item(nameLabel: "Category 2", priceLabel: 15, stockLabel: 25, photo: "photo2"),
            Item(nameLabel: "Category 3", priceLabel: 20, stockLabel: 30, photo: "photo3")
        ]

//        let categoriesInSection2 = [
//            Item(nameLabel: "Category A", priceLabel: 25, stockLabel: 15, photo: "photoA"),
//            Item(nameLabel: "Category B", priceLabel: 30, stockLabel: 10, photo: "photoB"),
//            Item(nameLabel: "Category C", priceLabel: 35, stockLabel: 5, photo: "photoC")
//        ]

        // 清除之前的 snapshot
        snapshot = NSDiffableDataSourceSnapshot<Category, Item>()

        // Apply fake data to the snapshot
        snapshot.appendSections([.item])
        snapshot.appendItems(categoriesInSection1, toSection: .item)
        //snapshot.appendItems(categoriesInSection2, toSection: .item)

        // Apply the snapshot to the dataSource
        dataSource.apply(snapshot, animatingDifferences: true)
        print(snapshot)
    }
    
    // ---------------------------------------------------
    
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
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    
    @objc private func addButtonTapped() {
        let addCategoryViewController = AddCategoryViewController()
        addCategoryViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addCategoryViewController, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

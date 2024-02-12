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
    
    var selectedCategory: LSCategory?
    var nameLabel: String?
    var price: Int?
    var amount: Int?
    var photo: UIImage?
    
    private lazy var addItemViewModel: AddItemViewModel = {
        return AddItemViewModel(
            doneTitle: NSLocalizedString("AddVC.done"),
            clearTitle: NSLocalizedString("Clear"),
            doneColor: UIColor.black,
            clearColor: UIColor.black,
            doneBackgroundColor: UIColor.lightGray,
            clearBackgroundColor: UIColor.lightGray,
            categoryTitleLabel: NSLocalizedString("AddVC.categoryTitleLabel"),
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
            backgroundColor: .none)
    }()
    
    var snapshot = NSDiffableDataSourceSnapshot<AddItemSection, CellType>()
    var dataSource: UITableViewDiffableDataSource<AddItemSection, CellType>!
    private let showListArray = CellType.allCases.map { $0.rawValue }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addItemTableView)
        addItemTableView.delegate = self
        setupUI()
        configureDataSource()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocalStorageManager.shared.fetchCategorys() { [weak self] result in
            switch result {
            case .success(_):
                // update categorys array
                self?.updateCategoryCell()
            case .failure(let error):
                print("Failed to fetch category names: \(error)")
            }
        }
        
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
        guard let selectedCategory = selectedCategory else {
            print("don't have category")
            return
        }
        
        guard let nameLabel = nameLabel, let price = price, let amount = amount else {
            print("Item details are incomplete")
            return
        }
        
        // Use the selected category when saving the item
        LocalStorageManager.shared.saveItem(itemName: nameLabel, price: price, amount: amount, photoData: UIImage(named: "demo"), inCategory: selectedCategory) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.selectedCategory = nil
                self.nameLabel = nil
                self.price = nil
                self.amount = nil
                // Clear the categoryTextField
                // Clear the text fields
                let indexPaths: [IndexPath] = [
                    IndexPath(row: CellType.item.rawValue, section: 0),
                    IndexPath(row: CellType.price.rawValue, section: 0),
                    IndexPath(row: CellType.amount.rawValue, section: 0)
                ]
                
                indexPaths.forEach { indexPath in
                    if let cell = self.addItemTableView.cellForRow(at: indexPath) as? ClearableTextFieldCell {
                        cell.clearTextField()
                    }
                }
                
                // go back to homeVC
                if let tabBarController = self.tabBarController {
                        tabBarController.selectedIndex = 0
                    }
                print("Item saved successfully.")
                
            case .failure(let error):
                print("Failed to save item: \(error)")
            }
        }
    }
    
    @objc private func cancelButtonTapped() {
        // Clear the categoryTextField
        // Clear the text fields
        let indexPaths: [IndexPath] = [
            IndexPath(row: CellType.item.rawValue, section: 0),
            IndexPath(row: CellType.price.rawValue, section: 0),
            IndexPath(row: CellType.amount.rawValue, section: 0)
        ]
        
        indexPaths.forEach { indexPath in
            if let cell = self.addItemTableView.cellForRow(at: indexPath) as? ClearableTextFieldCell {
                cell.clearTextField()
            }
        }
    }
    
}

// MARK: - UITableViewDelegate
extension AddItemViewController: UITableViewDelegate {
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<AddItemSection, CellType>(
            tableView: addItemTableView,
            cellProvider: { tableView, indexPath, cellType in
                switch cellType {
                case .photo:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.photoImageView.image = UIImage(named: "demo")
                    return cell
                    
                case .category:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                        return UITableViewCell()
                    }
                    self.configureCategoryTextField(cell.categoryTextField, with: LocalStorageManager.shared.categorys)
                    
                    return cell
                    
                case .item:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.updateDataHandler = { [weak self] in
                        // Call the updateDataHandler to refresh the UI
                        self?.configureItemTextField(cell.itemTextField, with: LocalStorageManager.shared.items)
                    }
                    
                    return cell
                    
                case .price:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.identifier, for: indexPath) as? PriceTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.updateDataHandler = { [weak self] in
                        // Call the updateDataHandler to refresh the UI
                        self?.configurePriceTextField(cell.priceTextField, with: LocalStorageManager.shared.items)
                    }
                    return cell
                    
                case .amount:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: AmountTableViewCell.identifier, for: indexPath) as? AmountTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.updateDataHandler = { [weak self] in
                        // Call the updateDataHandler to refresh the UI
                        self?.configureAmountTextField(cell.amountTextField, with: LocalStorageManager.shared.items)
                    }
                    return cell
                }
            }
        )
    }
    
    private func applySnapshot() {
        // clean snapShot
        snapshot = NSDiffableDataSourceSnapshot<AddItemSection, CellType>()
        snapshot.appendSections([.main])
        
        // Assuming `showListArray` contains `CellType` raw values
        let cellTypes = showListArray.compactMap { CellType(rawValue: $0) }
        snapshot.appendItems(cellTypes, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
   
    private func updateCategoryCell() {
        // Get the current snapshot
        var currentSnapshot = dataSource.snapshot()
        // Check if there is a cell of type .category
        guard let sectionIndex = currentSnapshot.sectionIdentifiers.firstIndex(of: .main),
              let categoryIndex = currentSnapshot.itemIdentifiers(inSection: .main).firstIndex(of: .category) else {
            return
        }
        // Reset the data for the .category type cell
        let indexPath = IndexPath(row: categoryIndex, section: sectionIndex)
        if let cell = addItemTableView.cellForRow(at: indexPath) as? CategoryTableViewCell {
            self.configureCategoryTextField(cell.categoryTextField, with: LocalStorageManager.shared.categorys)
        }
    }

    func configureCategoryTextField(_ textField: UITextField, with lsCategorys: [LSCategory]) {
        let categoryData = lsCategorys.compactMap { $0.title }
        textField.loadDropdownData(data: categoryData) { selectedText in
            self.selectedCategory = LocalStorageManager.shared.categorys.first { $0.title == selectedText }
            print("Selected category: \(selectedText)")
        }
    }
    
    func configureItemTextField(_ textField: UITextField, with lsItems: [LSItem]) {
        self.nameLabel = textField.text
    }
    func configurePriceTextField(_ textField: UITextField, with lsItems: [LSItem]) {
        self.price = Int(textField.text ?? "0")
    }
    func configureAmountTextField(_ textField: UITextField, with lsItems: [LSItem]) {
        self.amount = Int(textField.text ?? "0")
    }
    
}

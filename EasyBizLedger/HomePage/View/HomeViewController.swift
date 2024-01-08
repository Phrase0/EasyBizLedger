//
//  HomeViewController.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2023/12/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var homeViewModel: HomeViewModel = {
        return HomeViewModel(
            title: NSLocalizedString("HomeVC.addCategory", comment: ""),
            color: UIColor.systemBlue,
            imageName: "plus")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddButtonUI()
        setupUI()
        
    }
    
    private func setupAddButtonUI() {
        // create UIButton
        let addButton = UIButton(type: .custom)
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
    
    @objc private func addButtonTapped() {
        let addCategoryViewController = AddCategoryViewController()
        addCategoryViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addCategoryViewController, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .baseBackgroundColor
    }
 
}

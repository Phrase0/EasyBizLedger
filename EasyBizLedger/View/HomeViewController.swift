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
        
        setupTableViewUI()
        setupUI()
        
    }
    
    private func setupUI() {
        // create UIButton
        let customButton = UIButton(type: .custom)
        customButton.setTitle(homeViewModel.title, for: .normal)
        customButton.setTitleColor(homeViewModel.color, for: .normal)
        customButton.setImage(UIImage(systemName: homeViewModel.imageName), for: .normal)
        customButton.imageView?.contentMode = .scaleAspectFit
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
        
        // set button size
        customButton.sizeToFit()
        
        // create a UIBarButtonItem
        let customBarButtonItem = UIBarButtonItem(customView: customButton)
        
        navigationItem.rightBarButtonItem = customBarButtonItem
    }
    
    private func setupTableViewUI() {
        view.backgroundColor = .baseBackgroundColor
    }
    
    @objc private func customButtonTapped() {
        print("Custom button tapped!")
    }
    
}



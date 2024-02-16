//
//  UINavigationController+Extension.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2023/12/26.
//

import UIKit

extension UINavigationController {
    static var home: UINavigationController {
        return addNavigationController(for: HomeViewController(), title: "home")
    }
    static var add: UINavigationController {
        return addNavigationController(for: AddItemViewController(), title: "add")
    }
    static var list: UINavigationController {
        return addNavigationController(for: ListViewController(), title: "list")
    }
    
    private static func addNavigationController(
        for rootViewController: UIViewController,
        title: String?
    ) -> UINavigationController {

        let navigationController = UINavigationController(rootViewController: rootViewController)
//        let barApperance = UINavigationBarAppearance()
//        barApperance.shadowColor = UIColor.clear
//        navigationController.navigationBar.layer.opacity = 0.9
//        navigationController.navigationBar.layer.backgroundColor = UIColor.clear.cgColor
//
//        navigationController.navigationBar.prefersLargeTitles = true
//
//        navigationController.navigationItem.largeTitleDisplayMode = .automatic
//        navigationController.navigationBar.largeTitleTextAttributes = [
//            .foregroundColor: UIColor.setColor(lightColor: .darkGray, darkColor: .white),
//            .font: UIFont.boldSystemFont(ofSize: 28)
//        ]

        //rootViewController.navigationItem.title = title
        return navigationController
    }
}

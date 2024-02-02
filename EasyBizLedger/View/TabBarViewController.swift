//
//  TabBarViewController.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2023/12/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let tabs: [Tab] = [.home, .add, .list]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load core data
        LocalStorageManager.shared.fetchCategorys { _ in
            // Set up tab bar controller when data is loaded
            viewControllers = tabs.map { $0.makeViewController() }
            let barAppearance =  UITabBarAppearance()
            barAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = barAppearance
        }
        self.delegate = self
        self.tabBar.tintColor = .orange  
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Tabs
extension TabBarViewController {
    private enum Tab {
        case home
        case add
        case list

        func makeViewController() -> UIViewController {
            let controller: UIViewController
            switch self {
            case .home: controller = UINavigationController.home
            case .add: controller = UINavigationController.add
            case .list: controller = UINavigationController.list
            }
            controller.tabBarItem = makeTabBarItem()
            return controller
        }
        
        private func makeTabBarItem() -> UITabBarItem {
            return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        }
        
        private var title: String {
            switch self {
            case .home:
                return "首頁"
            case .add:
                return "新增"
            case .list:
                return "我的清單"
            }
        }
        private var image: UIImage? {
            switch self {
            case .home:
                return .systemAsset(.house)
            case .add:
                return UIImage(systemName: "plus.square")
            case .list:
                return UIImage(systemName: "chart.bar")
            }
        }
        private var selectedImage: UIImage? {
            switch self {
            case .home:
                return .systemAsset(.selectedHouse)
            case .add:
                return UIImage(systemName: "plus.square.fill")
            case .list:
                return UIImage(systemName: "chart.bar.fill")
            }
        }
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        return true
    }
}

//
//  TabBarController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/11/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createNavController(TodayController(), "Today", "today_icon"),
            createNavController(AppsSearchController(), "Search", "search"),
            createNavController(AppsPageController(), "Apps", "apps")]

    }

    fileprivate func createNavController(_ VC: UIViewController, _ title: String, _ imageName: String) -> UIViewController {
        let nav = UINavigationController(rootViewController: VC)
        nav.navigationBar.prefersLargeTitles = true
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: imageName)
        VC.view.backgroundColor = .white
        VC.navigationItem.title = title
        return nav
    }
}

 //
 //  AppTabController.swift
 //  zikr
 //
 //  Created by Ahmed Ebaid on 6/9/18.
 //  Copyright © 2018 Ahmed Ebaid. All rights reserved.
 //
import UIKit

class AppTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.white
        configureTabBarItems()
    }
    
    private func configureTabBarItems() {
        let azkarController = AzkarViewController(viewModel: ZikrQuranViewModel())
        setTabBarItem(for: azkarController, imageName: "Azkar", tag: 0)
        
        let doaaController = DoaaTableViewController()
        setTabBarItem(for: azkarController, imageName: "Doaa", tag: 1)
    
        let settingsNavigationController = UINavigationController(rootViewController: SettingsTableViewController(viewModel: SettingsViewModel(client: AzkarClient())))
        setTabBarItem(for: settingsNavigationController, imageName: "Settings", tag: 2)
        
        viewControllers = [azkarController, doaaController, settingsNavigationController]
    }
    
    private func setTabBarItem(for controller: UIViewController, imageName: String, tag: Int) {
        controller.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: imageName), tag: tag)   
    }
}

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
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        let viewModel = ZikrQuranViewModel()
        let azkarController = AzkarViewController(viewModel: viewModel)
        azkarController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Azkar"), tag: 0)
        
        let doaaController = DoaaTableViewController()
        doaaController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Doaa"), tag: 1)
    
        let client = AzkarClient()
        let settingsNavigationController = UINavigationController(rootViewController: SettingsTableViewController(viewModel: SettingsViewModel(client: client)))
        settingsNavigationController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Settings"), tag: 2)
        
        viewControllers = [azkarController, doaaController, settingsNavigationController]
    }
}

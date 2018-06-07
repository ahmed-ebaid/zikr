import UIKit

class AppTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.white
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        var attributededStringKeys: [NSAttributedStringKey: Any] = [:]
        attributededStringKeys[.font] = UIFont.systemFont(ofSize: 10, weight: .bold)
        
        let azkarController = AzkarViewController()
        azkarController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Sabah"), tag: 0)
        azkarController.tabBarItem.setTitleTextAttributes(attributededStringKeys, for: .normal)
        //        azkarController.tableView.scrollIndicatorInsets.bottom = tabBar.frame.height + 50
        
        let doaaController = DoaaTableViewController()
        doaaController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Doaa"), tag: 1)
        doaaController.tabBarItem.setTitleTextAttributes(attributededStringKeys, for: .normal)
        
        let settingsNavigationController = UINavigationController(rootViewController: SettingsTableViewController())
        settingsNavigationController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Settings"), tag: 2)
        attributededStringKeys[.font] = UIFont.systemFont(ofSize: 10, weight: .bold)
        settingsNavigationController.tabBarItem.setTitleTextAttributes(attributededStringKeys, for: .normal)
        
        viewControllers = [azkarController, doaaController, settingsNavigationController]
    }
}

import UIKit

class AppTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = UIColor.darkGray
        
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        var attributededStringKeys: [NSAttributedStringKey: Any] = [:]
        attributededStringKeys[.font] = UIFont.systemFont(ofSize: 10, weight: .bold)
        
        let azkarController = AzkarCollectionViewController(nibName: "AzkarCollectionViewController", bundle: nil)
        azkarController.tabBarItem = UITabBarItem(title: "أذكار الصباح والمساء", image: UIImage(named: "Sabah"), tag: 0)
        azkarController.tabBarItem.setTitleTextAttributes(attributededStringKeys, for: .normal)
//        azkarController.tableView.scrollIndicatorInsets.bottom = tabBar.frame.height + 50
        
        let doaaController = DoaaTableViewController()
        doaaController.tabBarItem = UITabBarItem(title: "أدعية مختارة", image: UIImage(named: "Doaa"), tag: 1)
        doaaController.tabBarItem.setTitleTextAttributes(attributededStringKeys, for: .normal)
        
        let settingsNavigationController = UINavigationController(rootViewController: SettingsTableViewController())
        settingsNavigationController.tabBarItem = UITabBarItem(title: "إعدادات", image: UIImage(named: "Settings"), tag: 2)
        attributededStringKeys[.font] = UIFont.systemFont(ofSize: 10, weight: .bold)
        settingsNavigationController.tabBarItem.setTitleTextAttributes(attributededStringKeys, for: .normal)

        self.viewControllers = [azkarController, doaaController, settingsNavigationController]
    }
}

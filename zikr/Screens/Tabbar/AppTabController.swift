import UIKit

class AppTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.backgroundColor = UIColor.white
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        let azkarController = AzkarViewController()
        azkarController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Azkar"), tag: 0)
        
        let doaaController = DoaaTableViewController()
        doaaController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Doaa"), tag: 1)
    
        let client = AzkarClient()
        let settingsNavigationController = UINavigationController(rootViewController: SettingsTableViewController(viewModel: SettingsViewModel(client: client)))
        settingsNavigationController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Settings"), tag: 2)
        
        viewControllers = [azkarController, doaaController, settingsNavigationController]
    }
}

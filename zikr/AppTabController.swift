import UIKit

class AppTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = UIColor.darkGray
        
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        
        let azkarNavigationController = NavigationControllerHelper(rootViewController: MorningAndNightAzkarTableViewController()).getNavigationWithTabBarItemSetForController(title: "أذكار الصباح والمساء", image: UIImage(named: "Sabah")
, tag: 0)
        
       let quranicNavigationController = NavigationControllerHelper(rootViewController: QuranicPrayers()).getNavigationWithTabBarItemSetForController(title: "أدعية مختارة", image: UIImage(named: "Doaa"), tag: 1)
        
        let settingsNavigationController = NavigationControllerHelper(rootViewController: SettingsTableViewController()).getNavigationWithTabBarItemSetForController(title: "إعدادات", image: UIImage(named: "Settings"), tag: 2)
        

        self.viewControllers = [azkarNavigationController, quranicNavigationController, settingsNavigationController]
    }
}

import UIKit

class NavigationControllerHelper {
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func getNavigationWithTabBarItemSetForController(title: String, image: UIImage?, tag: Int) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        var attributededStringKeys: [NSAttributedStringKey: Any] = [:]
        attributededStringKeys[.font] = UIFont.systemFont(ofSize: 10, weight: .bold)
        navigationController.tabBarItem.setTitleTextAttributes(attributededStringKeys, for: .normal)
        return navigationController
    }
}

import CoreLocation
import Foundation
import UIKit
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let settingsViewModel = SettingsViewModel(client: AzkarClient())
    let changeLocationViewModel = ChangeLocationViewModel()
    let calculationMethodViewModel = CalculationMethodViewModel()
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let tabController = AppTabController()
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        changeLocationViewModel.delegate = self
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
            if error == nil {
                if result {
                    if UserDefaults.isFirstLaunch() {
                        self.calculationMethodViewModel.setCalculationMethod()
                        self.changeLocationViewModel.getCurrentLocation()
                    }
                }
            }
        }
        return true
    }
}

extension AppDelegate: ChangeLocationViewModelDelegate {
    func changeLocationViewModelDidRecieveLocation() {
        settingsViewModel.getAzkarTimes {
            self.settingsViewModel.restartAzkarNotifications()
        }
    }
}

//
//  AppDelegate.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/10/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import CoreLocation
import Foundation
import UIKit
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let viewModel = SettingsViewModel(client: AzkarClient())
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let tabController = AppTabController()
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
                NotificationCenter.default.addObserver(self, selector: #selector(didChangeLocationNotification), name: Location.DidChangeLocationNotification, object: nil)
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
            if error == nil {
                if result {
                    if UserDefaults.isFirstLaunch() {
                        self.viewModel.calculationMethod.setCalculationMethod()
                        self.viewModel.location.getCurrentLocation()
                    }
                }
            }
        }
        return true
    }
    
    @objc private func didChangeLocationNotification() {
        viewModel.getAzkarTimes {
            self.viewModel.refreshAzkarNotifications()
        }
    }
}

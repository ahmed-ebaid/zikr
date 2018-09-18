//
//  SettingsViewModel.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import Foundation

class SettingsViewModel {
    let client: AzkarClientProtocol
    let location: Location
    let calculationMethod: CalculationMethod
    let sharedModel: AzkarData
    let azkarNotificationsModel: AzkarNotificationsModel

    init(client: AzkarClientProtocol) {
        self.client = client
        location = Location()
        calculationMethod = CalculationMethod()
        sharedModel = AzkarData.sharedInstance
        azkarNotificationsModel = AzkarNotificationsModel()
    }

    func getAzkarTimes(completion: @escaping () -> Void) {
        let favoritedLocations = location.favoritedLocations
        guard let latitude = favoritedLocations[0].latitude, let longitude = favoritedLocations[0].longitude else {
            return
        }
        let calculationMethod = self.calculationMethod.calculationMethodIndex

        guard let month = Date.month, let year = Date.year else {
            return
        }

        client.getAzkarTimes(latitude: Double(truncating: latitude), longitude: Double(truncating: longitude), method: calculationMethod, month: month, year: year) { _, result in
            if let azkarTimes = result as? [ZikrNotificationTime] {
                self.sharedModel.zikrNotificationTimes = azkarTimes
                if self.sharedModel.zikrNotificationTimes.count < 20 {
                    self.requestMoreAzkarTimes {
                        completion()
                    }
                }
            }
        }
    }

    private func requestMoreAzkarTimes(completion: @escaping () -> Void) {
        guard let latitude = location.favoritedLocations[0].latitude, let longitude = location.favoritedLocations[0].longitude else {
            return
        }
        let calculationMethod = self.calculationMethod.calculationMethodIndex

        guard let date = Calendar.current.date(byAdding: .month, value: 1, to: Date()) else {
            return
        }

        let dateComponents = Date.getDateComponents(for: date)
        guard let month = dateComponents.month, let year = dateComponents.year else {
            return
        }

        client.getAzkarTimes(latitude: Double(truncating: latitude), longitude: Double(truncating: longitude), method: calculationMethod, month: month, year: year) { _, result in
            if let azkarTimes = result as? [ZikrNotificationTime] {
                for zikrTime in azkarTimes {
                    self.sharedModel.zikrNotificationTimes.append(zikrTime)
                    if self.sharedModel.zikrNotificationTimes.count == 20 {
                        break
                    }
                }
            }
            completion()
        }
    }

    func refreshAzkarNotifications() {
        azkarNotificationsModel.removeNotifications()
        azkarNotificationsModel.toggleNotifications(true)
    }
}

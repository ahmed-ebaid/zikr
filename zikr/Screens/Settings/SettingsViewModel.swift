import Foundation

class SettingsViewModel {
    let client: AzkarClientProtocol
    let changeLocationViewModel: ChangeLocationViewModel
    let calculationMethodViewModel: CalculationMethodViewModel
    let sharedModel: AzkarData
    let azkarNotificationsModel = AzkarNotificationsModel()

    init(client: AzkarClientProtocol) {
        self.client = client
        calculationMethodViewModel = CalculationMethodViewModel()
        changeLocationViewModel = ChangeLocationViewModel()
        sharedModel = AzkarData.sharedInstance
    }

    func getAzkarTimes(completion: @escaping () -> Void) {
        guard let latitude = changeLocationViewModel.favoritedLocations[0].latitude, let longitude = changeLocationViewModel.favoritedLocations[0].longitude else {
            return
        }
        let calculationMethod = calculationMethodViewModel.calculationMethod

        guard let month = Date.month, let year = Date.year else {
            return
        }

        client.getAzkarTimes(latitude: Double(truncating: latitude), longitude: Double(truncating: longitude), method: calculationMethod, month: month, year: year) { error, azkarTimes in
            if error == nil && azkarTimes != nil {
                self.sharedModel.zikrNotificationTimes = azkarTimes as! [ZikrNotificationTime]
                if self.sharedModel.zikrNotificationTimes.count < 20 {
                    self.requestMoreAzkarTimes {
                        completion()
                    }
                }
            }
        }
    }

    private func requestMoreAzkarTimes(completion: @escaping () -> Void) {
        guard let latitude = changeLocationViewModel.favoritedLocations[0].latitude, let longitude = changeLocationViewModel.favoritedLocations[0].longitude else {
            return
        }
        let calculationMethod = calculationMethodViewModel.calculationMethod
        guard let month = Date.nextMonth, let year = Date.nextYear else {
            return
        }

        client.getAzkarTimes(latitude: Double(truncating: latitude), longitude: Double(truncating: longitude), method: calculationMethod, month: month, year: year) { error, azkarTimes in
            if error == nil && azkarTimes != nil {
                let azkarTimes = azkarTimes as! [ZikrNotificationTime]
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

    func restartAzkarNotifications() {
        azkarNotificationsModel.removeNotifications()
        azkarNotificationsModel.toggleNotifications(true)
    }
}

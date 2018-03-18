import Foundation

class SettingsViewModel {
    let client: AzkarClientProtocol
    let changeLocationViewModel: ChangeLocationViewModel
    let calculationMethodViewModel: CalculationMethodViewModel
    let sharedModel : AzkarData
    let azkarNotificationsModel = AzkarNotificationsModel()
    
    init(client: AzkarClientProtocol) {
        self.client = client
        calculationMethodViewModel = CalculationMethodViewModel()
        changeLocationViewModel = ChangeLocationViewModel()
        sharedModel = AzkarData.shared
    }
    
    func getAzkarTimes(completion: @escaping () -> Void) {
        let clLocation = changeLocationViewModel.favoritedLocations[0].clLocation
        guard let latitude = clLocation?.coordinate.latitude, let longitude = clLocation?.coordinate.longitude else {
            return
        }
        let calculationMethod = calculationMethodViewModel.calculationMethod
        
        guard let month = Date.month, let year = Date.year else {
            return
        }
        
        client.getAzkarTimes(latitude: latitude, longitude: longitude, method: calculationMethod, month: month, year: year) { error, azkarTimes in
            if error == nil && azkarTimes != nil {
                self.sharedModel.azkarData = azkarTimes as! [AzkarTime]
                if self.sharedModel.azkarData.count < 20 {
                    self.requestMoreAzkarTimes {
                        completion()
                    }
                }
            }
        }
    }
    
    private func requestMoreAzkarTimes(completion: @escaping () -> Void) {
        let clLocation = changeLocationViewModel.favoritedLocations[0].clLocation
        guard let latitude = clLocation?.coordinate.latitude, let longitude = clLocation?.coordinate.longitude else {
            return
        }
        let calculationMethod = calculationMethodViewModel.calculationMethod
        guard let month = Date.nextMonth, let year = Date.nextYear else {
            return
        }
        
        client.getAzkarTimes(latitude: latitude, longitude: longitude, method: calculationMethod, month: month, year: year) { error, azkarTimes in
            if error == nil && azkarTimes != nil {
                let azkarTimes = azkarTimes as! [AzkarTime]
                for zikrTime in azkarTimes {
                    self.sharedModel.azkarData.append(zikrTime)
                    if self.sharedModel.azkarData.count == 20 {
                        break
                    }
                }
            }
            completion()
        }
    }
    
    func restartAzkarNotifications() {
        azkarNotificationsModel.resetAzkarNotifications()
        azkarNotificationsModel.toggleNotifications(true)
    }
    
}

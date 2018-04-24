 import UserNotifications
 
 class AzkarNotificationsModel: NSObject, UNUserNotificationCenterDelegate {
    let center = UNUserNotificationCenter.current()
    let zikrContent = UNMutableNotificationContent()
    let fajrIdentifier = "FajrIdentifier"
    let asrIdentifier = "AsrIdentifier"
    let sharedModel = AzkarData.sharedInstance
    
    private func configureAzkarNotifications() -> [UNNotificationRequest] {
        var notificationRequests = [UNNotificationRequest]()
        var i = 0
        for zikrNotificationTime in sharedModel.zikrNotificationTimes {
            notificationRequests.append(addNotificationRequest(for: zikrNotificationTime, isFajrNotification: true, notificationId: i))
            notificationRequests.append(addNotificationRequest(for: zikrNotificationTime, isFajrNotification: false, notificationId: i))
            i += 1
        }
        return notificationRequests
    }
    
    private func addNotificationRequest(for zikrNotificationTime: ZikrNotificationTime, isFajrNotification: Bool, notificationId: Int) -> UNNotificationRequest {
        
        zikrContent.title = isFajrNotification ? "وقت أذكار الصباح" :
        "وقت أذكار المساء"
        zikrContent.body = "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ"
        zikrContent.sound = UNNotificationSound.default()
        var dateComponents = Date.getDateComponentsFrom(date: zikrNotificationTime.date)
        let zikrTime = isFajrNotification ? getZikrTime(zikrNotificationTime.timings.fajr) : getZikrTime(zikrNotificationTime.timings.asr)
        
        dateComponents.hour = zikrTime.0
        dateComponents.minute = zikrTime.1
        dateComponents.second = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        return UNNotificationRequest(identifier: isFajrNotification ? fajrIdentifier : asrIdentifier + "\(notificationId)", content: zikrContent, trigger: trigger)
    }
    
    func toggleNotifications(_ value: Bool) {
        if value {
            let azkarNotificaitionsRequests = configureAzkarNotifications()
            for azkarNotification in azkarNotificaitionsRequests {
                center.add(azkarNotification) { error in
                    if error != nil {
                        print("error \(String(describing: error))")
                    }
                }
            }
        } else {
            removeNotifications()
        }
    }
    
    func removeNotifications() {
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
    }
    
    private func getZikrTime(_ stringTime: String) -> (Int, Int) {
        let stringArray = stringTime.split(separator: ":")
        guard let hour = Int(stringArray[0]), let minute = Int(stringArray[1].split(separator: " ")[0]) else {
            return (0, 0)
        }
        return (hour, minute)
    }
    
    // Marker Delegate Methods
    func userNotificationCenter(_: UNUserNotificationCenter, didReceive _: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge]) // required to show notification when in foreground
    }
 }

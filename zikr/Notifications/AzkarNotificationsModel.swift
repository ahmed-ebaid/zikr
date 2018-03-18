import UserNotifications

class AzkarNotificationsModel: NSObject, UNUserNotificationCenterDelegate {
    let center =  UNUserNotificationCenter.current()
    let fagrAzkarContent = UNMutableNotificationContent()
    let asrAzkarContent = UNMutableNotificationContent()
    let asrIdentifier = "AsrIdentifier"
    let fagrIdentifier = "IshaIdentifier"
    let sharedModel = AzkarData.shared
    
    
    private func configureAzkarNotifications() -> [UNNotificationRequest] {
        var notificationRequests = [UNNotificationRequest]()
        var i = 0
        for zikrDate in sharedModel.azkarData {
            if i != 0 {
                i += 1
            }
            fagrAzkarContent.title = "وقت أذكار الصباح"
            fagrAzkarContent.subtitle = "الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَمَاتِنَا وَإِلَيْهِ النُّشُورِ"
            fagrAzkarContent.body = "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ"
            fagrAzkarContent.sound = UNNotificationSound.default()
            var fagrDateComponents = Date.getDateComponentsFrom(date: zikrDate.date)
            let fagrTime = getZikrTime(zikrDate.timings.Fajr)
            fagrDateComponents.hour = fagrTime.0
            fagrDateComponents.minute = fagrTime.1 + 20
            fagrDateComponents.second = 0
            let fagrTrigger = UNCalendarNotificationTrigger(dateMatching: fagrDateComponents, repeats: false)
            notificationRequests.append(UNNotificationRequest(identifier: fagrIdentifier + "\(i)", content: fagrAzkarContent, trigger: fagrTrigger))
            
            i += 1
            asrAzkarContent.title = "وقت أذكار المساء"
            asrAzkarContent.subtitle = "الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَمَاتِنَا وَإِلَيْهِ النُّشُورِ"
            asrAzkarContent.body = "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ"
            asrAzkarContent.sound = UNNotificationSound.default()
            var asrDateComponents = Date.getDateComponentsFrom(date: zikrDate.date)
            let asrTime = getZikrTime(zikrDate.timings.Asr)
            asrDateComponents.hour = asrTime.0
            asrDateComponents.minute = asrTime.1 + 20
            asrDateComponents.second = 0
            let asrTrigger = UNCalendarNotificationTrigger(dateMatching: asrDateComponents, repeats: false)
            notificationRequests.append(UNNotificationRequest(identifier: asrIdentifier + "\(i)", content: asrAzkarContent, trigger: asrTrigger))
        }
        return notificationRequests
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
            center.removeAllPendingNotificationRequests()
        }
    }
    
    func resetAzkarNotifications() {
        center.removePendingNotificationRequests(withIdentifiers: [asrIdentifier, fagrIdentifier])
    }
    
    private func getZikrTime(_ stringTime: String) -> (Int, Int) {
        let stringArray = stringTime.split(separator: ":")
        guard let hour = Int(stringArray[0]), let minute = Int(stringArray[1].split(separator: " ")[0])  else {
            return (0,0)
        }
        
        return (hour, minute)
    }

    
    //Marker Delegate Methods
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge]) //required to show notification when in foreground
    }
    
}
